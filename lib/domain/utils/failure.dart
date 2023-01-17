import 'package:freezed_annotation/freezed_annotation.dart';

import 'errors.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure({
    String? content,
    Errors? error,
  }) = _Failure;
}
