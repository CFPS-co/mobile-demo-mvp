import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const padding = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
      ),
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
                    Translation.of(context).settings,
                    style: getIt<ThemeManager>().textStyles.headline1,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  SettingsMenuItem(
                    name: Translation.of(context).changePinCode,
                    icon: ImgPathsPng.iconChangePinCode,
                    onTapCallback: () => context.router.push(
                      LoginWithPinCodeRoute(loginType: LoginWithPinType.setPin),
                    ),
                  ),
                  SettingsMenuItem(
                    name: Translation.of(context).changePassword,
                    icon: ImgPathsPng.iconPaperBank,
                    onTapCallback: () {
                      // context.router.push(CreatePasswordRoute());
                    },
                  ),

                  // ! temporaty
                  SettingsMenuItem(
                    name: 'KYC',
                    icon: ImgPathsPng.iconPaperBank,
                    onTapCallback: () {
                      context.router.push(const KycRoute());
                    },
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

class SettingsMenuItem extends StatelessWidget {
  const SettingsMenuItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTapCallback,
  }) : super(key: key);

  final String name;

  /// Should be path to .png
  final String icon;
  final VoidCallback onTapCallback;

  static const leadingIconWidth = 40.0;
  static const trailingIconWidth = 10.0;
  static const spaceFromRight = 4.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onTapCallback,
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: spaceFromRight),
          title: Text(
            name,
            style: getIt<ThemeManager>().textStyles.bodyText2Regular,
            textAlign: TextAlign.left,
          ),
          leading: Image.asset(
            icon,
            width: leadingIconWidth,
          ),
          trailing: SvgPicture.asset(
            ImgPathsSvg.iconChevronRight,
            width: trailingIconWidth,
          ),
        ),
      ),
    );
  }
}
