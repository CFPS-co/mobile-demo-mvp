import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWithBackButton extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
        onPressed: () => context.router.pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
