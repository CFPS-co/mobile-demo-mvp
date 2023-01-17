import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSelectButton extends StatelessWidget {
  const AppSelectButton(
    this.text, {
    super.key,
    this.label,
    this.onPressed,
    this.width = double.maxFinite,
    this.height = 60.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  final String text;
  final String? label;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.holly10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      textAlign: TextAlign.left,
                      style: getIt<ThemeManager>().textStyles.bodyText3Medium.copyWith(color: AppColors.holly40),
                    ),
                  Text(
                    text,
                    textAlign: TextAlign.left,
                    style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.black),
                  ),
                ],
              ),
              SvgPicture.asset(ImgPathsSvg.iconChevronDown),
            ],
          ),
        ),
      );
}
