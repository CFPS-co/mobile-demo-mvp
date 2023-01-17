import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNoInternetConnection extends StatelessWidget {
  const AppNoInternetConnection({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translation.of(context).checkYourInternetConnection,
            style: getIt<ThemeManager>().textStyles.headline1,
          ),
          SvgPicture.asset(ImgPathsSvg.iconNoInternetConnection),
          SizedBox(
            height: 56,
            child: AppButton(
              Translation.of(context).retry,
              style: getIt<ThemeManager>().buttonStyles.roundedButton,
              onPressed: onPressed,
            ),
          ),
        ],
      );
}
