import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.controller,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
    this.errorText,
    this.suffixIcon,
  });

  static const _padding = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const _borderRadius = 8.0;
  static const _borderWidth = 2.0;
  static const _cursorHeight = 16.0;

  final String title;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final Function(String)? onChanged;
  final String? errorText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: _padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText == null ? AppColors.defaultActiveColor : AppColors.bitterSweet,
              width: _borderWidth,
            ),
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(color: AppColors.edward),
              ),
              const Gap(4),
              TextFormField(
                controller: controller,
                onChanged: onChanged,
                cursorColor: AppColors.defaultActiveColor,
                cursorHeight: _cursorHeight,
                inputFormatters: inputFormatters,
                enabled: enabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  suffixIcon: suffixIcon,
                ),
              ),
            ],
          ),
        ),
        const Gap(4),
        if (errorText != null)
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Text(
              errorText!,
              style: getIt<ThemeManager>().textStyles.bodyText3Regular.copyWith(
                    color: AppColors.bitterSweet,
                  ),
            ),
          ),
      ],
    );
  }
}
