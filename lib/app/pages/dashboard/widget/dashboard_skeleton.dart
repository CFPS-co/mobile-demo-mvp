import 'package:cfps/app/theme/app_colors.dart';
import 'package:cfps/app/theme/theme_manager.dart';
import 'package:cfps/app/utils/translations/generated/l10n.dart';
import 'package:cfps/app/widget/app_skeleton.dart';
import 'package:cfps/injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class DashboardPageSkeleton extends StatelessWidget {
  const DashboardPageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.defaultBackground,
        body: Column(
          children: const [
            SizedBox(height: 32),
            _SkeletonAccountBalance(),
            SizedBox(height: 8),
            _SkeletonCardsSection(),
            SizedBox(height: 8),
            _SkeletonLastTransactions(),
          ],
        ),
      );
}

class _SkeletonLastTransactions extends StatelessWidget {
  const _SkeletonLastTransactions({Key? key}) : super(key: key);

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
            Text(
              Translation.of(context).lastTransactions,
              style: getIt<ThemeManager>().textStyles.bodyText1Medium,
            ),
            const SizedBox(height: 24),
            Column(
              children: const [
                _SkeletonLastTransactionsItem(),
                SizedBox(height: 16),
                _SkeletonLastTransactionsItem(),
                SizedBox(height: 16),
                _SkeletonLastTransactionsItem(),
              ],
            )
          ],
        ),
      );
}

class _SkeletonLastTransactionsItem extends StatelessWidget {
  const _SkeletonLastTransactionsItem({Key? key}) : super(key: key);

  static const avatarDimension = 40.0;
  static final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppSkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: borderRadius,
                    height: avatarDimension,
                    width: avatarDimension,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              AppSkeletonItem(
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    width: MediaQuery.of(context).size.width * 0.20,
                    borderRadius: borderRadius,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppSkeletonItem(
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 12,
                    width: MediaQuery.of(context).size.width * 0.20,
                    borderRadius: borderRadius,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AppSkeletonItem(
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 8,
                    width: MediaQuery.of(context).size.width * 0.10,
                    borderRadius: borderRadius,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

class _SkeletonCardsSection extends StatelessWidget {
  const _SkeletonCardsSection({Key? key}) : super(key: key);

  static const padding = EdgeInsets.all(16);
  static final borderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SkeletonCardsSectionItem(),
            SizedBox(height: 16),
            _SkeletonCardsSectionItem(),
          ],
        ),
      );
}

class _SkeletonCardsSectionItem extends StatelessWidget {
  const _SkeletonCardsSectionItem({Key? key}) : super(key: key);

  static const avatarHeight = 34.0;
  static const avatarWidth = 24.0;

  static final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppSkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(3),
                    height: avatarHeight,
                    width: avatarWidth,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeletonItem(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.20,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppSkeletonItem(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 8,
                        width: MediaQuery.of(context).size.width * 0.10,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSkeletonItem(
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 12,
                width: MediaQuery.of(context).size.width * 0.20,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      );
}

class _SkeletonAccountBalance extends StatelessWidget {
  const _SkeletonAccountBalance({Key? key}) : super(key: key);

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
            Text(
              Translation.of(context).accountBalance,
              style: getIt<ThemeManager>().textStyles.bodyText1SemiBold,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
            AppSkeletonItem(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 22,
                  width: MediaQuery.of(context).size.width * 0.45,
                  borderRadius: borderRadius,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppSkeletonItem(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 44,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppSkeletonItem(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 44,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
}
