import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_response.freezed.dart';

@freezed
class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    required String clientId,
  }) = _SignInResponse;
}
