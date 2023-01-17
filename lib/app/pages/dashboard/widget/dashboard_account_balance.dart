import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_text_icon_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';

class DashboardAccountBalanceWidget extends StatelessWidget {
  const DashboardAccountBalanceWidget({
    super.key,
    required this.balance,
    required this.currency,
    required this.onAddFundsPressed,
    required this.onSendFundsPressed,
  });

  final double balance;
  final String currency;
  final VoidCallback onAddFundsPressed;
  final VoidCallback onSendFundsPressed;

  static const padding = EdgeInsets.all(16);

  static final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.of(context).accountBalance,
              style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            Text(
              balanceString,
              style: hasNegativeBalance
                  ? getIt<ThemeManager>().textStyles.avenir32Medium.copyWith(
                        color: AppColors.bitterSweet,
                      )
                  : getIt<ThemeManager>().textStyles.avenir32Medium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    Translation.of(context).sendFunds,
                    icon: const Icon(Icons.arrow_right_alt),
                    onPressed: hasNoBalance ? null : onSendFundsPressed,
                    style: getIt<ThemeManager>()
                        .buttonStyles
                        .roundedButtonWithIcon,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: hasNoBalance
                      ? _AccountBalanceNoDepositMadeAddFundsButton(
                          onPressed: onAddFundsPressed,
                        )
                      : _AccountBalanceDepositMadeAddFundsButton(
                          onPressed: onAddFundsPressed,
                        ),
                )
              ],
            ),
          ],
        ),
      );

  bool get hasNoBalance => balance == 0.00;

  bool get hasNegativeBalance => balance < 0.00;

  String get balanceString => '${balance.toStringAsFixed(2)} $currency';
}

class _AccountBalanceNoDepositMadeAddFundsButton extends StatelessWidget {
  const _AccountBalanceNoDepositMadeAddFundsButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => AppButton(
        Translation.of(context).addFunds,
        icon: const Icon(Icons.add),
        style: getIt<ThemeManager>().buttonStyles.roundedButtonWithIcon,
        onPressed: onPressed,
      );
}

class _AccountBalanceDepositMadeAddFundsButton extends StatelessWidget {
  const _AccountBalanceDepositMadeAddFundsButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => AppTextIconButton(
        title: Translation.of(context).addFunds,
        icon: const Icon(Icons.add),
        onPressed: onPressed,
      );
}
