import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class YourPasswordChangedPage extends StatelessWidget {
  const YourPasswordChangedPage({super.key});

  static const padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.of(context).congrats,
                  style: getIt<ThemeManager>().textStyles.headline1,
                  textAlign: TextAlign.left,
                ),
                const Gap(16),
                Text(
                  Translation.of(context).yourPasswordChanged,
                  style: getIt<ThemeManager>().textStyles.bodyText1Regular,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Column(
              children: [
                AppButton(
                  Translation.of(context).done,
                  style: getIt<ThemeManager>().buttonStyles.roundedButton,
                  onPressed: () {
                    context.router.pushAndPopUntil(const SignInRoute(), predicate: (_) => false);
                  },
                ),
                const Gap(16),
              ],
            )
          ],
        ),
      ),
    );
  }
}
