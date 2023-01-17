import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/profile/widgets/app_bar_with_back_button.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_text_icon_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';

class ConfirmPinResetPage extends StatelessWidget {
  const ConfirmPinResetPage({Key? key}) : super(key: key);

  static const _buttonHeight = 56.0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarWithBackButton(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Translation.of(context).confirmThePinReset, style: getIt<ThemeManager>().textStyles.headline1),
                Column(
                  children: [
                    SizedBox(
                      height: _buttonHeight,
                      child: AppButton(
                        Translation.of(context).confirm,
                        style: getIt<ThemeManager>().buttonStyles.roundedButton,
                        onPressed: () =>
                            context.router.pushAndPopUntil(const SignInRoute(), predicate: (route) => false),
                      ),
                    ),
                    SizedBox(
                      height: _buttonHeight,
                      child: AppTextIconButton(
                        title: Translation.of(context).cancel,
                        onPressed: () => context.router.pop(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
