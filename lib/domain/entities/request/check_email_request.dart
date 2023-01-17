import 'package:cfps/data/dto/request/mvp_demo/check_email_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'check_email_request.freezed.dart';

@freezed
class CheckEmailRequest with _$CheckEmailRequest {
  const factory CheckEmailRequest({
    required String email,
  }) = _CheckEmailRequest;
}

extension CheckEmailRequestExt on CheckEmailRequest {
  CheckEmailRequestDto get toDto => CheckEmailRequestDto(email: email);
}
