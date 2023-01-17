import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_navigation_bar_item.freezed.dart';

@freezed
class AppNavigationBarItem with _$AppNavigationBarItem {
  const factory AppNavigationBarItem({
    required List<BottomNavigationBarItem> navBar,
    required List<Widget> widget,
  }) = _AppNavigationBarItem;
}


