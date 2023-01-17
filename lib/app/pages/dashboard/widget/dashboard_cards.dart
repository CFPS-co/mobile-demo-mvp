import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_text_icon_button.dart';
import 'package:cfps/domain/entities/cfps_card.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({
    super.key,
    required this.cards,
    required this.balance,
    required this.onOpenCardCallback,
    required this.onCardTapCallback,
  });

  final List<CfpsCard> cards;
  final double balance;

  final VoidCallback onOpenCardCallback;
  final Function(CfpsCard card) onCardTapCallback;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cards.isNotEmpty)
                  Text(
                    Translation.of(context).cards,
                    style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
                    textAlign: TextAlign.left,
                  ),
                ...cards.take(1).map(
                      (card) => GestureDetector(
                        onTap: () {
                          onCardTapCallback(card);
                        },
                        child: CardItem(
                          card: card,
                        ),
                      ),
                    ),
                // TODO for mvp commnet this out
                if (false && cards.length <= 1)
                  AppButton(
                    Translation.of(context).openTheCard,
                    style: getIt<ThemeManager>().buttonStyles.secondaryButton,
                    onPressed: () {
                      if (balance == 0.0 && cards.isEmpty) {
                        showOpenCardBottomSheet(context);
                      } else {
                        onOpenCardCallback();
                      }
                    },
                  )
              ],
            )
          ],
        ),
      );

  showOpenCardBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        height: 260,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Text(
              Translation.of(context).pleaseDepositAccount,
              style: getIt<ThemeManager>().textStyles.headline3SemiBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Translation.of(context).minimalDeposit,
                    style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.black),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: Translation.of(context).euro15,
                    style: getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(color: AppColors.black),
                  ),
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: Translation.of(context).recommendedDeposit,
                    style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.black),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: Translation.of(context).euro300,
                    style: getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(color: AppColors.black),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: Translation.of(context).orMore,
                    style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppTextIconButton(
              title: Translation.of(context).addFunds,
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.card});

  final CfpsCard card;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: CardName(
        card: card,
      ),
      subtitle: card.isReordered
          ? const CardReordered()
          : card.isOrdered
              ? const CardOrderedName()
              : card.isBlocked
                  ? const CardBlocked()
                  : CardNumber(card: card),
      leading: CardImage(card: card),
      trailing: card.isOrdered
          ? const CardOrderedText()
          : CardBalance(
              card: card,
            ),
    );
  }
}

class CardReordered extends StatelessWidget {
  const CardReordered({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Translation.of(context).cardOrdered,
      style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.silverSand),
    );
  }
}

class CardBalance extends StatelessWidget {
  const CardBalance({super.key, required this.card});

  final CfpsCard card;

  @override
  Widget build(BuildContext context) {
    return Text(
      card.balanceString,
      style: card.isReordered
          ? getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(
                color: AppColors.silverSand,
              )
          : card.hasNegativeBalance
              ? getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(
                    color: AppColors.bitterSweet,
                  )
              : getIt<ThemeManager>().textStyles.bodyText1Medium,
    );
  }
}

class CardOrderedText extends StatelessWidget {
  const CardOrderedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Translation.of(context).cardOrdered,
      style: getIt<ThemeManager>().textStyles.bodyText2Regular.copyWith(color: AppColors.silverSand),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.card});

  final CfpsCard card;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      card.isBlocked || card.isOrdered ? ImgPathsPng.blockedCard : card.imageUrl,
      width: 35,
      fit: BoxFit.contain,
    );
  }
}

class CardNumber extends StatelessWidget {
  const CardNumber({super.key, required this.card});

  final CfpsCard card;

  @override
  Widget build(BuildContext context) {
    return Text(
      trimCardNumber(card.number),
      style: getIt<ThemeManager>().textStyles.bodyText2Regular,
    );
  }

  String trimCardNumber(String cardNumber) {
    if(cardNumber.length == 4){
      return ".. ${cardNumber.substring(cardNumber.length - 4)}";
    } else {
      return '..$cardNumber';
    }
  }
}

class CardBlocked extends StatelessWidget {
  const CardBlocked({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Translation.of(context).cardIsBlocked,
      style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(color: AppColors.bitterSweet),
    );
  }
}

class CardOrderedName extends StatelessWidget {
  const CardOrderedName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "......",
      style: getIt<ThemeManager>().textStyles.bodyText1Regular,
    );
  }
}

class CardName extends StatelessWidget {
  const CardName({super.key, required this.card});

  final CfpsCard card;

  @override
  Widget build(BuildContext context) {
    return Text(
      card.name,
      style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
    );
  }
}
