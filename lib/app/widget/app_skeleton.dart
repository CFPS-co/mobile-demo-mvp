import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AppSkeletonItem extends StatelessWidget {
  const AppSkeletonItem({super.key, required this.child});

  static const skeletonDuration = Duration(milliseconds: 2000);

  final Widget child;

  @override
  Widget build(BuildContext context) => Skeleton(
        isLoading: true,
        duration: skeletonDuration,
        skeleton: child,
        child: const SizedBox.shrink(),
      );
}
