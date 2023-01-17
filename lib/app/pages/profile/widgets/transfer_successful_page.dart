import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransferSuccessfulPage extends StatelessWidget {
  const TransferSuccessfulPage({super.key});

  static const padding = EdgeInsets.all(16);

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
                    Translation.of(context).transferSuccessful,
                    style: getIt<ThemeManager>().textStyles.headline1,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Center(child: SvgPicture.asset(ImgPathsSvg.iconPig)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    Translation.of(context).done,
                    style: getIt<ThemeManager>().buttonStyles.roundedButton,
                    onPressed: () => context.router.pushAndPopUntil(
                      const HomeRoute(),
                      predicate: (_) => false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
