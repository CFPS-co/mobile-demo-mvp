import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:cfps/app/pages/dashboard/widget/dasboard_last_transactions.dart';
import 'package:cfps/app/pages/dashboard/widget/dashboard_account_balance.dart';
import 'package:cfps/app/pages/dashboard/widget/dashboard_cards.dart';
import 'package:cfps/app/pages/dashboard/widget/dashboard_skeleton.dart';
import 'package:cfps/app/pages/dashboard/widget/utils/card_mock.dart';
import 'package:cfps/app/pages/dashboard/widget/utils/transaction_mock.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_top_snackbar.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DashboardPage extends HookWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static const padding = EdgeInsets.all(8);
  static const euroSign = '€';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Container(
        padding: padding,
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) => state.maybeWhen(
            orElse: () => const DashboardPageSkeleton(),
            loaded: (details) => CustomRefreshIndicator(
              builder: MaterialIndicatorDelegate(
                builder: (_, controller) {
                  return const Card(
                    shape: CircleBorder(),
                    color: AppColors.concrete,
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.concrete,
                      color: AppColors.blueDianne,
                    ),
                  );
                },
              ),
              onRefresh: () => context.read<DashboardCubit>().load(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                        showAppTopSnackBar(context, Translation.of(context).comingSoon);
                      },
                      child: DashboardAccountBalanceWidget(
                        balance: details.accountBalance,
                        currency: euroSign,
                        onAddFundsPressed: () {
                          context.router
                              .push(SendFundsRoute(accountBalance: details.accountBalance, cards: details.cards));
                        },
                        onSendFundsPressed: () {
                          context.router
                              .push(SendFundsRoute(accountBalance: details.accountBalance, cards: details.cards));
                        },
                      ),
                    ),
                    const Gap(16),
                    if (details.cards.isNotEmpty && details.lastTransactions.isNotEmpty) ...[
                      DashboardCards(
                        balance: details.accountBalance,
                        cards: details.cards,
                        onOpenCardCallback: () {},
                        onCardTapCallback: (cardMock) {},
                      ),
                      const Gap(16),
                      DashboardLastTransactions(
                        transactions: details.lastTransactions,
                        onTransactionTapCallback: (transactionMock) {
                          showAppTopSnackBar(context, Translation.of(context).comingSoon);
                        },
                      ),
                    ] else
                      const NoTransactionOrCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> editTransactionDialog(
    BuildContext context,
    ValueNotifier<List<TransactionMock>> mockedTransactions,
    TransactionMock transactionMock,
    ValueNotifier<List<CardMock>> mockedCards,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                'Delete',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedTransactions.value;
                  tmpList.remove(transactionMock);
                  mockedTransactions.value = [...tmpList];
                  Navigator.pop(context);
                },
              ),
              const Gap(4),
              AppButton(
                'Invert amount',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedTransactions.value;
                  tmpList.firstWhere((element) => element.shopName == transactionMock.shopName).balance =
                      transactionMock.balance * -1;
                  mockedTransactions.value = [...tmpList];
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> editCardDialog(BuildContext context, ValueNotifier<List<CardMock>> mockedCards, CardMock cardMock) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                'Delete',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedCards.value;
                  tmpList.remove(cardMock);
                  mockedCards.value = [...tmpList];
                  Navigator.pop(context);
                },
              ),
              const Gap(4),
              AppButton(
                'Toggle blocked',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedCards.value;
                  tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).isBlocked =
                      !cardMock.isBlocked;
                  mockedCards.value = [...tmpList];
                  Navigator.pop(context);
                },
              ),
              const Gap(4),
              AppButton(
                'Toggle type',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedCards.value;
                  tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).cardName =
                      cardMock.cardName == "Euro Card" ? "Virtual Card" : "Euro Card";

                  tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).imageUrl =
                      cardMock.cardName == "Euro Card" ? ImgPathsPng.euroCard : ImgPathsPng.virtualCard;
                  mockedCards.value = [...tmpList];
                  Navigator.pop(context);
                },
              ),
              const Gap(4),
              AppButton(
                'Invert balance',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  final tmpList = mockedCards.value;
                  tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).balance =
                      cardMock.balance * -1;
                  mockedCards.value = [...tmpList];

                  Navigator.pop(context);
                },
              ),
              const Gap(4),
              if (cardMock.cardName == "Euro Card")
                AppButton(
                  'Toggle ordered',
                  style: getIt<ThemeManager>().buttonStyles.roundedButton,
                  onPressed: () {
                    final tmpList = mockedCards.value;
                    tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).isOrdered =
                        !cardMock.isOrdered;
                    mockedCards.value = [...tmpList];
                    Navigator.pop(context);
                  },
                ),
              if (cardMock.cardName == "Virtual Card")
                AppButton(
                  'Toggle reordered',
                  style: getIt<ThemeManager>().buttonStyles.roundedButton,
                  onPressed: () {
                    final tmpList = mockedCards.value;
                    tmpList.firstWhere((element) => element.cardNumber == cardMock.cardNumber).isReordered =
                        !cardMock.isReordered;
                    mockedCards.value = [...tmpList];
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showBalanceDialog(BuildContext context, ValueNotifier<double> balance) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: euroSign,
                ),
                initialValue: balance.value.toStringAsFixed(2),
                onChanged: (value) {
                  if (value.isEmpty) {
                    balance.value = 0.0;
                  } else {
                    balance.value = double.parse(value);
                  }
                },
              ),
              const Gap(8),
              AppButton(
                'OK',
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoTransactionOrCard extends StatelessWidget {
  const NoTransactionOrCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Text(
          Translation.of(context).depositAccountToOrderCard,
          style: getIt<ThemeManager>().textStyles.headline2.copyWith(
                color: AppColors.defaultActiveColor,
              ),
          textAlign: TextAlign.center,
        ),
        SvgPicture.asset(ImgPathsSvg.iconPig),
      ],
    );
  }
}
