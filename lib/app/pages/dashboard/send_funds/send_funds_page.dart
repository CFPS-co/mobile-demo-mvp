import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/dashboard/widget/dashboard_cards.dart';
import 'package:cfps/app/pages/profile/widgets/app_bar_with_back_button.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/utils/widgets/rounded_white_container.dart';
import 'package:cfps/domain/entities/cfps_card.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SendFundsPage extends StatelessWidget {
  const SendFundsPage({super.key, required this.accountBalance, required this.cards});

  final double accountBalance;
  final List<CfpsCard> cards;

  static const euroSign = '€';

  static const padding = EdgeInsets.all(16);
  static const paddingVertical = EdgeInsets.symmetric(vertical: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButton(),
      body: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: CustomExpansionpanel(
                cards: cards,
                balance: accountBalance,
              ),
            )
          ],
        ),
      ),
    );
  }

  bool get hasNoBalance => accountBalance == 0.00;

  bool get hasNegativeBalance => accountBalance < 0.00;

  String get balanceString => '${accountBalance.toStringAsFixed(2)} $euroSign';
}

class CustomExpansionpanel extends HookWidget {
  const CustomExpansionpanel({
    Key? key,
    required this.cards,
    required this.balance,
  }) : super(key: key);

  final List<CfpsCard> cards;
  final double balance;

  @override
  Widget build(BuildContext context) {
    var isPanelExpanded = useState<bool>(false);

    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      elevation: 0,
      expansionCallback: (panelIndex, isExpanded) {
        isPanelExpanded.value = !isExpanded;
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isPanelExpanded.value,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Select an account"),
              leading: SvgPicture.asset(ImgPathsSvg.iconPlus),
            );
          },
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: cards
                .take(1)
                .map(
                  (card) => GestureDetector(
                    onTap: () => context.router.push(
                      SendFundsDetailsRoute(
                        accountBalance: balance,
                        card: card,
                      ),
                    ),
                    child: CardItem(card: card),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class AccountItemTile extends StatelessWidget {
  const AccountItemTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.balanceString,
  }) : super(key: key);

  final String balanceString;
  final String icon;
  final String title;
  static const iconWitdh = 40.0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        icon,
        width: iconWitdh,
      ),
      title: Text(
        title,
        style: getIt<ThemeManager>().textStyles.bodyText1Medium,
      ),
      trailing: Text(
        balanceString,
        style: getIt<ThemeManager>().textStyles.bodyText1Medium,
      ),
    );
  }
}
