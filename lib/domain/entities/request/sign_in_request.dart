import 'package:cfps/data/dto/request/mvp_demo/sign_in_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_request.freezed.dart';

@freezed
class SignInRequest with _$SignInRequest {
  const factory SignInRequest({
    required String email,
    required String password,
  }) = _SignInRequest;
}

extension SignInRequestExt on SignInRequest {
  SignInRequestDto get toDto => SignInRequestDto(
        email: email,
        password: password,
      );
}
