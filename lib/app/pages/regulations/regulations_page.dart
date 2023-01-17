import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum RegulationsType { termsAndConditions, privacyPolicy }

class RegulationsPage extends HookWidget {
  const RegulationsPage({required this.type, super.key});

  final RegulationsType type;

  @override
  Widget build(BuildContext context) {
    final title = useState<String>('');
    final content = Translation.of(context).comingSoon;
    switch (type) {
      case RegulationsType.termsAndConditions:
        title.value = Translation.of(context).termsAndConditions;
        break;
      case RegulationsType.privacyPolicy:
        title.value = Translation.of(context).privacyPolicy;
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          title.value,
          style: getIt<ThemeManager>().textStyles.bodyText1Medium.copyWith(
                color: AppColors.black,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              content,
              style: getIt<ThemeManager>().textStyles.bodyText1Regular,
            )
          ],
        ),
      ),
    );
  }
}
