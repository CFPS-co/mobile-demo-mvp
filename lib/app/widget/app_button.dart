import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.text, {
    super.key,
    required this.style,
    this.textStyle,
    this.onPressed,
    this.width = double.maxFinite,
    this.height = 42.0,
    this.icon,
  });

  final Widget? icon;
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle style;
  final TextStyle? textStyle;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: FittedBox(
            alignment: Alignment.center,
            child: Row(
              children: [
                if (icon != null)
                  Row(
                    children: [
                      icon!,
                      const SizedBox(width: 8),
                    ],
                  ),
                Text(text, style: textStyle),
              ],
            ),
          ),
        ),
      );
}
