import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/about/cubit/about_cubit.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const padding = EdgeInsets.all(16.0);
  static const ver = "Product Version 01.01.0 (00000)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.of(context).about,
                  style: getIt<ThemeManager>().textStyles.headline1,
                  textAlign: TextAlign.left,
                ),
                const Gap(16),
                AboutItem(
                  name: Translation.of(context).termsAndConditions,
                  icon: ImgPathsPng.iconTerms,
                  onTapCallback: () {},
                ),
                AboutItem(
                  name: Translation.of(context).privacyPolicy,
                  icon: ImgPathsPng.iconShield,
                  onTapCallback: () {},
                ),
                AboutItem(
                  name: Translation.of(context).softwareLicense,
                  icon: ImgPathsPng.iconLicense,
                  onTapCallback: () {},
                ),
              ],
            ),
            Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocProvider(
                    create: (context) => getIt<AboutCubit>(),
                    child: BlocBuilder<AboutCubit, AboutState>(
                      builder: (context, state) => state.maybeWhen(
                        loaded: (version) => Text("${Translation.of(context).productVersion} $version"),
                        orElse: () => const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutItem extends StatelessWidget {
  const AboutItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTapCallback,
  }) : super(key: key);

  final String name;

  /// Should be path to .png
  final String icon;
  final VoidCallback onTapCallback;

  static const leadingIconWidth = 40.0;
  static const trailingIconWidth = 10.0;
  static const spaceFromRight = 4.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onTapCallback,
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: spaceFromRight),
          title: Text(
            name,
            style: getIt<ThemeManager>().textStyles.bodyText2Regular,
            textAlign: TextAlign.left,
          ),
          leading: Image.asset(
            icon,
            width: leadingIconWidth,
          ),
          trailing: SvgPicture.asset(
            ImgPathsSvg.iconChevronRight,
            width: trailingIconWidth,
          ),
        ),
      ),
    );
  }
}
