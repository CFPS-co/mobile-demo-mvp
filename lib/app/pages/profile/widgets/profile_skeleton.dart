import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_skeleton.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ProfilePageSkeletion extends StatelessWidget {
  const ProfilePageSkeletion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.defaultBackground,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSkeletonItem(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.6,
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _SkeletonContainer(
                  items: const [
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                  ],
                  name: Translation.of(context).account,
                ),
                const SizedBox(height: 8),
                _SkeletonContainer(
                  items: const [
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                    _ItemSkeleton(),
                    SizedBox(height: 24),
                  ],
                  name: Translation.of(context).general,
                ),
                const SizedBox(height: 8),
                const _SkeletonContainer(
                  items: [
                    _ItemSkeleton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _SkeletonContainer extends StatelessWidget {
  const _SkeletonContainer({
    this.name,
    required this.items,
  });

  final String? name;
  final List<Widget> items;

  static const padding = EdgeInsets.all(16);

  static final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) => Container(
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
                style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
                textAlign: TextAlign.left,
              ),
            ...items,
          ],
        ),
      );
}

class _ItemSkeleton extends StatelessWidget {
  const _ItemSkeleton({
    Key? key,
  }) : super(key: key);

  static const bigRadius = BorderRadius.all(Radius.circular(90));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 30,
                  height: 30,
                  borderRadius: bigRadius,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: AppSkeletonItem(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 30,
                      borderRadius: bigRadius,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 20,
            height: 20,
            borderRadius: bigRadius,
          ),
        ),
      ],
    );
  }
}
