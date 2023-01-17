import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/utils/widgets/rounded_white_container.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
  }) : super(key: key);

  static const padding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: RoundedWhiteContainer(
          child: Padding(
            padding: padding,
            child: CircularProgressIndicator(
              color: AppColors.defaultActiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
