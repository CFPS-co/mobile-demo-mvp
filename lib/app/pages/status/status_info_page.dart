import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/domain/entities/status_info_page_arguments.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatusInfoPage extends StatelessWidget {
  const StatusInfoPage({super.key, required this.arguments});

  static const _buttonHeight = 56.0;
  static const _padding = EdgeInsets.all(16.0);

  final StatusInfoPageArguments arguments;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: _padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(48),
                Text(
                  arguments.title,
                  style: getIt<ThemeManager>().textStyles.headline1,
                ),
                const Gap(8),
                if (arguments.subTitle != null)
                  Text(
                    arguments.subTitle!,
                    style: getIt<ThemeManager>().textStyles.bodyText2Regular,
                  ),
                const Spacer(),
                SizedBox(
                  height: _buttonHeight,
                  child: AppButton(
                    Translation.of(context).done,
                    style: getIt<ThemeManager>().buttonStyles.roundedButton,
                    onPressed: arguments.onPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
