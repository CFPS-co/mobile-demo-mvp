import 'package:freezed_annotation/freezed_annotation.dart';
import 'success_messages.dart';

part 'success.freezed.dart';

@freezed
class Success with _$Success {
  const factory Success({SuccessMessages? successMessage}) = _Success;
}
