import 'package:auto_route/auto_route.dart';
import 'package:cfps/app/pages/profile/tariff_page/cubit/tariff_cubit.dart';
import 'package:cfps/app/pages/profile/tariff_page/widgets/tariff_row_item.dart';
import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/img_paths_svg.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TariffPage extends StatelessWidget {
  const TariffPage({super.key});

  static const padding = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TariffCubit>(),
      child: BlocBuilder<TariffCubit, TariffState>(
        builder: (_, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (list) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              elevation: 0,
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(ImgPathsSvg.iconArrowLeft),
                onPressed: () => context.router.pop(),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.of(context).tariff,
                      style: getIt<ThemeManager>().textStyles.headline1,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 22),
                    Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (_, index) {
                          final item = list[index];

                          return TariffRowItem(
                            label: item.label,
                            value: item.value,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
