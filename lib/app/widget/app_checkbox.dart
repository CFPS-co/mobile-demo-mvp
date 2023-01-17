import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.onChanged,
    this.isChecked = false,
    this.color = AppColors.blueDianne,
    this.outlineColor = AppColors.edward,
    this.borderWidth = 1,
    this.size = 18,
  });

  final bool isChecked;
  final Color color;
  final Color outlineColor;
  final double borderWidth;
  final double size;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: isChecked ? color : AppColors.white,
          border: Border.all(
            width: borderWidth,
            color: isChecked ? color : outlineColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.transparent),
          child: Checkbox(
            activeColor: Colors.transparent,
            value: isChecked,
            onChanged: (val) => onChanged?.call(val!),
          ),
        ),
      );
}
