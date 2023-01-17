import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/snackbars.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_text_icon_button.dart';
import 'package:cfps/app/widget/app_top_snackbar.dart';
import 'package:cfps/domain/entities/transaction.dart';
import 'package:cfps/domain/entities/transaction_type.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardLastTransactions extends StatelessWidget {
  const DashboardLastTransactions({
    super.key,
    required this.transactions,
    required this.onTransactionTapCallback,
  });

  final List<Transaction> transactions;
  final Function(Transaction transactionMock) onTransactionTapCallback;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.of(context).lastTransactions,
                  style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
                  textAlign: TextAlign.left,
                ),
                AppTextIconButton(
                  title: Translation.of(context).seeAll,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showAppTopSnackBar(context, Translation.of(context).comingSoon);
                  },
                )
              ],
            ),
            const SizedBox(height: 8),
            ...transactions.reversed.take(5).map((transaction) {
              return ListTile(
                onTap: () {
                  onTransactionTapCallback(transaction);
                },
                contentPadding: EdgeInsets.zero,
                title: TransactionName(transaction: transaction),
                trailing: TransactionBalance(transaction: transaction),
                leading: TransactionIcon(transaction: transaction),
              );
            }).toList(),
          ],
        ),
      );
}

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({Key? key, required this.transaction}) : super(key: key);

  final Transaction transaction;

  String _getImgPathForTransactionType() {
    switch (transaction.type) {
      case TransactionType.income:
        return ImgPathsSvg.iconTransfer;
      case TransactionType.internal:
        return ImgPathsSvg.iconRefresh;
      case TransactionType.outcome:
        return ImgPathsSvg.iconShop;
      default:
        return ImgPathsSvg.iconRefresh;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: AppColors.concrete, borderRadius: BorderRadius.circular(8)),
      child: SvgPicture.asset(
        _getImgPathForTransactionType(),
        fit: BoxFit.scaleDown,
        height: 24,
        width: 24,
      ),
    );
  }
}

class TransactionName extends StatelessWidget {
  const TransactionName({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Text(
      transaction.merchantName,
      style: getIt<ThemeManager>().textStyles.avenir16Medium,
    );
  }
}

class TransactionBalance extends StatelessWidget {
  const TransactionBalance({super.key, required this.transaction});

  final Transaction transaction;

  String _getAmountText() {
    var amount = transaction.amount.toStringAsFixed(2);
    if (transaction.amount == transaction.amount.floor()) {
      amount = amount.substring(0, amount.length - 3);
    }

    amount += " ${transaction.currency}";

    switch (transaction.type) {
      case TransactionType.income:
        return "+ $amount";
      case TransactionType.outcome:
        return "- $amount";
      default:
        return amount;
    }
  }

  Color _getColorForTransactionType() {
    switch (transaction.type) {
      case TransactionType.income:
        return AppColors.defaultActiveColor;
      default:
        return AppColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _getAmountText(),
          style: getIt<ThemeManager>().textStyles.bodyText2Medium.copyWith(
                color: _getColorForTransactionType(),
              ),
        ),
        const SizedBox(height: 2),
        Text(
          transaction.sourceName,
          style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(
                color: AppColors.silverSand,
              ),
        ),
      ],
    );
  }
}
