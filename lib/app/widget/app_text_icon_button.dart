import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';

class AppTextIconButton extends StatelessWidget {
  const AppTextIconButton({
    Key? key,
    this.title,
    this.icon,
    this.textStyle,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  final String? title;
  final Widget? icon;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: onPressed,
        style: padding == null
            ? getIt<ThemeManager>().buttonStyles.textWithIconButton
            : getIt<ThemeManager>().buttonStyles.textWithIconButton.copyWith(
                  padding: MaterialStatePropertyAll(
                    padding,
                  ),
                ),
        icon: icon ?? const SizedBox.shrink(),
        label: Text(
          title!,
          style: textStyle ?? getIt<ThemeManager>().textStyles.avenir16Medium,
        ),
      );
}
