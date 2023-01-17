import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonalInfoConfirmationPage extends StatelessWidget {
  const PersonalInfoConfirmationPage({super.key});

  static const padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.of(context).informationChange,
                    style: getIt<ThemeManager>().textStyles.headline1,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translation.of(context).informationChangeNotice,
                    style: getIt<ThemeManager>().textStyles.bodyText1Medium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Center(child: SvgPicture.asset(ImgPathsSvg.messagesImage)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    Translation.of(context).theContinue,
                    style: getIt<ThemeManager>().buttonStyles.roundedButton,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    Translation.of(context).cancel,
                    style: getIt<ThemeManager>().buttonStyles.secondaryButton,
                    onPressed: () => context.router.pop(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
