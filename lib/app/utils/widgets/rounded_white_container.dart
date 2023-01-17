import 'package:cfps/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedWhiteContainer extends StatelessWidget {
  const RoundedWhiteContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  static const conteinerPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: conteinerPadding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
