import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_info_page_arguments.freezed.dart';

@freezed
class StatusInfoPageArguments with _$StatusInfoPageArguments {
  const factory StatusInfoPageArguments({
    required String title,
    String? subTitle,
    required VoidCallback onPressed,
  }) = _StatusInfoPageArguments;
}
