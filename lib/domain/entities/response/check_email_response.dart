import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_email_response.freezed.dart';

@freezed
class CheckEmailResponse with _$CheckEmailResponse {
  const factory CheckEmailResponse({
    required String verificationCode,
  }) = _CheckEmailResponse;
}

