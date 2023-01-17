import 'package:cfps/app/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:cfps/app/pages/dashboard/dashboard_page.dart';
import 'package:cfps/app/pages/payments/payments_page.dart';
import 'package:cfps/app/pages/profile/cubit/profile_cubit.dart';
import 'package:cfps/app/pages/profile/profile_page.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_top_snackbar.dart';
import 'package:cfps/domain/entities/app_navigation_bar_item.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  static const borderRadius = Radius.circular(16);

  /// Nav bar pages
  static const widget = [
    DashboardPage(),
    PaymentsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final navigationIndex = useState<int>(0);
    final navigationItems = AppNavigationBarItem(
      navBar: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImgPathsSvg.iconHome,
            color: AppColors.gray,
          ),
          activeIcon: SvgPicture.asset(
            ImgPathsSvg.iconHome,
            color: AppColors.defaultActiveColor,
          ),
          label: Translation.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImgPathsSvg.iconPayments,
            color: AppColors.gray,
          ),
          activeIcon: SvgPicture.asset(
            ImgPathsSvg.iconPayments,
            color: AppColors.defaultActiveColor,
          ),
          label: Translation.of(context).payments,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImgPathsSvg.iconProfile,
            color: AppColors.gray,
          ),
          activeIcon: SvgPicture.asset(
            ImgPathsSvg.iconProfile,
            color: AppColors.defaultActiveColor,
          ),
          label: Translation.of(context).profile,
        ),
      ],
      widget: widget,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<DashboardCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.defaultBackground,
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.96,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius,
                  topRight: borderRadius,
                ),
                color: AppColors.white,
              ),
              child: BottomNavigationBar(
                backgroundColor: AppColors.transparent,
                elevation: 0,
                selectedItemColor: AppColors.defaultActiveColor,
                selectedLabelStyle: getIt<ThemeManager>().textStyles.avenir12Medium.copyWith(fontSize: 14),
                unselectedLabelStyle: getIt<ThemeManager>().textStyles.avenir12Medium,
                onTap: (index) => index == 1
                    ? showAppTopSnackBar(context, Translation.of(context).comingSoon)
                    : navigationIndex.value = index,

                // onTap: (index) => navigationIndex.value = index,
                currentIndex: navigationIndex.value,
                items: navigationItems.navBar,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: navigationItems.widget[navigationIndex.value],
        ),
      ),
    );
  }
}
