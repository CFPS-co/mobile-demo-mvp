import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/dashboard/send_funds/cubit/send_funds_cubit.dart';
import 'package:cfps/app/pages/dashboard/send_funds/send_funds_page.dart';
import 'package:cfps/app/pages/dashboard/widget/dashboard_cards.dart';
import 'package:cfps/app/pages/profile/widgets/app_bar_with_back_button.dart';
import 'package:cfps/app/pages/profile/widgets/app_loading_indicator.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/utils/widgets/rounded_white_container.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/domain/entities/cfps_card.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SendFundsDetailsPage extends HookWidget {
  const SendFundsDetailsPage({super.key, required this.accountBalance, required this.card});

  final double accountBalance;
  final CfpsCard card;

  static const euroSign = '€';

  static const padding = EdgeInsets.all(16);
  static const paddingVertical = EdgeInsets.symmetric(vertical: 16);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SendFundsCubit>(),
      child: BlocConsumer<SendFundsCubit, SendFundsState>(
        listener: (context, state) => state.maybeWhen(
          transferSuccess: () => context.router.pushAndPopUntil(
            const TransferSuccessfulRoute(),
            predicate: (_) => false,
          ),
          orElse: () => null,
        ),
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: const AppBarWithBackButton(),
                body: Padding(
                  padding: padding,
                  child: Stack(
                    children: [
                      ListView(
                        padding: const EdgeInsets.only(bottom: 100),
                        children: [
                          Text(
                            Translation.of(context).fromHere,
                            style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(
                                  color: AppColors.gray,
                                ),
                          ),
                          const Gap(16),
                          RoundedWhiteContainer(
                            child: AccountItemTile(
                              balanceString: balanceString,
                              icon: ImgPathsPng.iconAccountEruo,
                              title: Translation.of(context).accountBalance,
                            ),
                          ),
                          const Gap(16),
                          Text(
                            Translation.of(context).here,
                            style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(
                                  color: AppColors.gray,
                                ),
                          ),
                          const Gap(16),
                          RoundedWhiteContainer(
                            child: CardItem(
                              card: card,
                            ),
                          ),
                          const Gap(32),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RoundedWhiteContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: [
                                        CurrencyInputFormatter(
                                          trailingSymbol: euroSign,
                                          thousandSeparator: ThousandSeparator.None,
                                        )
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "0 $euroSign",
                                        hintStyle: getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(
                                              color: AppColors.gray,
                                            ),
                                      ),
                                      onChanged: (value) => context.read<SendFundsCubit>().updateDate(
                                            amount: double.parse(value.replaceAll(
                                              euroSign,
                                              '',
                                            )),
                                            accountbalance: accountBalance,
                                            requiredAmount: accountBalance,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              showAmountError(state, accountBalance, context),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppButton(
                            Translation.of(context).transferMoney,
                            style: getIt<ThemeManager>().buttonStyles.roundedButton,
                            onPressed: () {
                              context.read<SendFundsCubit>().buttonPressed();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state == const SendFundsState.amountCorrect()) const AppLoadingIndicator(),
            ],
          );
        },
      ),
    );
  }

  Widget showAmountError(SendFundsState state, double neededAmount, BuildContext context) {
    return state.maybeWhen(
      loaded: (amount, amountValidator) {
        if (amountValidator == ValidationError.amountTooShort) {
         return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  Translation.of(context).minimumDeposit(neededAmount.toStringAsFixed(2)),
                  style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                        color: AppColors.bitterSweet,
                      ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
      orElse: () => const SizedBox(),
    );
  }

  bool get hasNoBalance => accountBalance == 0.00;

  bool get hasNegativeBalance => accountBalance < 0.00;

  String get balanceString => '${accountBalance.toStringAsFixed(2)} $euroSign';
}
