import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../injectable/injectable.dart';

void showAppTopSnackBar(
  BuildContext context,
  String message,
) =>
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * .75,
            left: 16,
            right: 16,
          ),
          elevation: 8,
          backgroundColor: AppColors.white,
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              SvgPicture.asset(
                ImgPathsSvg.iconAlert,
                width: 32,
              ),
              const SizedBox(width: 12),
              Text(
                message,
                style: getIt<ThemeManager>().textStyles.mulish16Bold.copyWith(color: AppColors.black),
              )
            ],
          ),
        ),
      );
