import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_text_icon_button.dart';
import 'package:cfps/domain/use_case/remove_splash_screen_use_case.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class QuickStartPage extends HookWidget {
  const QuickStartPage({Key? key}) : super(key: key);

  static const _buttonHeight = 56.0;
  static const _padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    useMemoized(() => getIt<RemoveSplashScreenUseCase>()());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(ImgPathsSvg.wallet),
              ),
              const Spacer(),
              Text(
                Translation.of(context).quickStart,
                style: getIt<ThemeManager>().textStyles.headline1,
              ),
              const Gap(16),
              Text(
                Translation.of(context).openAnAccountAndAccess,
                style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(
                      color: AppColors.edward,
                    ),
              ),
              const Gap(24),
              SizedBox(
                height: _buttonHeight,
                child: AppButton(
                  Translation.of(context).createAnAccount,
                  style: getIt<ThemeManager>().buttonStyles.roundedButton,
                  textStyle: getIt<ThemeManager>().textStyles.bodyText1Medium,
                  onPressed: () => context.router.push(const SignUpEmailRoute()),
                ),
              ),
              SizedBox(
                height: _buttonHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: AppTextIconButton(
                    title: Translation.of(context).logIn,
                    textStyle: getIt<ThemeManager>().textStyles.bodyText1Medium,
                    onPressed: () => context.router.push(const SignInRoute()),
                  ),
                ),
              ),
              // SizedBox(
              //   height: _buttonHeight,
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: AppTextIconButton(
              //       title: 'Enter the app [DEV]',
              //       textStyle: getIt<ThemeManager>().textStyles.bodyText1Medium,
              //       onPressed: () => context.router.push(const HomeRoute()),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
