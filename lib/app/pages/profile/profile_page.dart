import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/profile/cubit/profile_cubit.dart';
import 'package:cfps/app/pages/profile/widgets/profile_skeleton.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_png.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/router.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_button.dart';
import 'package:cfps/app/widget/app_top_snackbar.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const listPadding = EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.defaultBackground,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) => state.whenOrNull(
            logout: () => context.router.pushAndPopUntil(
              const QuickStartRoute(),
              predicate: (route) => false,
            ),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => const ProfilePageSkeletion(),
            loaded: (client) => ProfileOptionsList(listPadding: listPadding, name: client.name),
          ),
        ),
      );
}

class ProfileOptionsList extends StatelessWidget {
  const ProfileOptionsList({
    Key? key,
    required this.listPadding,
    required this.name,
  }) : super(key: key);

  final EdgeInsets listPadding;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: listPadding,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            name,
            style: getIt<ThemeManager>().textStyles.headline1,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 16),
        ProfileMenuGroupContainer(
          name: Translation.of(context).account,
          items: [
            ProfileMenuItem(
              name: Translation.of(context).personalInfo,
              icon: ImgPathsPng.iconFace,
              onTapCallback: () {
                // context.router.push(const PersonalInfoRoute());
                showAppTopSnackBar(context, Translation.of(context).comingSoon);
              },
            ),
            ProfileMenuItem(
              name: Translation.of(context).tariff,
              icon: ImgPathsPng.iconTariff,
              onTapCallback: () => showAppTopSnackBar(context, Translation.of(context).comingSoon),
              // context.pushRoute(const TariffRoute()),
            ),
            ProfileMenuItem(
              name: Translation.of(context).settings,
              icon: ImgPathsPng.iconSettings,
              onTapCallback: () =>
                  // context.pushRoute(const SettingsRoute()),
                  showAppTopSnackBar(context, Translation.of(context).comingSoon),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ProfileMenuGroupContainer(
          name: Translation.of(context).general,
          items: [
            ProfileMenuItem(
              name: Translation.of(context).about,
              icon: ImgPathsPng.iconHeart,
              onTapCallback: () {
                showAppTopSnackBar(context, Translation.of(context).comingSoon);
                // context.router.push(const AboutRoute());
              },
            ),
            ProfileMenuItem(
              name: Translation.of(context).faq,
              icon: ImgPathsPng.iconQuestion,
              onTapCallback: () {
                showAppTopSnackBar(context, Translation.of(context).comingSoon);
              },
            ),
            ProfileMenuItem(
              name: Translation.of(context).logout,
              icon: ImgPathsPng.iconLogout,
              onTapCallback: () async {
                showLogOutBottomSheet(context, () => context.read<ProfileCubit>().logout());
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        ProfileMenuGroupContainer(
          items: [
            ProfileMenuItem(
              name: Translation.of(context).closeAccount,
              icon: ImgPathsPng.iconCloseAcount,
              onTapCallback: () {
                showAppTopSnackBar(context, Translation.of(context).comingSoon);
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<bool?> showLogOutBottomSheet(BuildContext ctx, VoidCallback onLogout) => showModalBottomSheet(
        context: ctx,
        backgroundColor: AppColors.transparent,
        builder: (context) => Container(
          height: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Text(
                Translation.of(context).signOut,
                style: getIt<ThemeManager>().textStyles.headline3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Translation.of(context).areYouSUreSignOut,
                      style: getIt<ThemeManager>().textStyles.bodyText1Regular.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                Translation.of(context).signOut,
                style: getIt<ThemeManager>().buttonStyles.roundedButton,
                onPressed: onLogout,
              ),
              const SizedBox(height: 16),
              AppButton(
                Translation.of(context).cancel,
                style: getIt<ThemeManager>().buttonStyles.secondaryButton,
                onPressed: () => context.router.pop(),
              ),
            ],
          ),
        ),
      );
}

class ProfileMenuGroupContainer extends StatelessWidget {
  const ProfileMenuGroupContainer({
    Key? key,
    this.name,
    required this.items,
    this.isSingleItem = false,
  }) : super(key: key);

  final String? name;
  final List<Widget> items;
  final bool isSingleItem;

  static final borderRadius = BorderRadius.circular(16);
  static const padding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (name != null)
            Text(
              name!,
              style: getIt<ThemeManager>().textStyles.bodyText1Regular,
              textAlign: TextAlign.left,
            ),
          if (isSingleItem) const SizedBox(height: 12),
          ...items
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
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
