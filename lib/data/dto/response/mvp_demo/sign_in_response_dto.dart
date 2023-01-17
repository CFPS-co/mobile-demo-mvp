import 'package:cfps/domain/entities/response/sign_in_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response_dto.g.dart';

@JsonSerializable()
class SignInResponseDto {
  SignInResponseDto({
    required this.clientId,
  });

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) => _$SignInResponseDtoFromJson(json);

  @JsonKey(name: 'client_id')
  final String clientId;

  Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);
}

extension SignInReponseDtoExt on SignInResponseDto {
  SignInResponse get toEntity => SignInResponse(
        clientId: clientId,
      );
}
