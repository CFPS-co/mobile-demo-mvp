import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';

class TariffRowItem extends StatelessWidget {
  const TariffRowItem({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: getIt<ThemeManager>().textStyles.bodyText1Medium),
          Text(value, style: getIt<ThemeManager>().textStyles.bodyText1Medium)
        ],
      ),
    );
  }
}
