import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/response/check_email_response.dart';

part 'check_email_response_dto.g.dart';

@JsonSerializable()
class CheckEmailResponseDto {
  CheckEmailResponseDto({
    required this.verificationCode,
  });

  factory CheckEmailResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckEmailResponseDtoFromJson(json);

  @JsonKey(name: 'verification_code')
  final String verificationCode;

  Map<String, dynamic> toJson() => _$CheckEmailResponseDtoToJson(this);
}

extension CheckEmailResponseDtoExt on CheckEmailResponseDto {
  CheckEmailResponse get toEntity =>
      CheckEmailResponse(verificationCode: verificationCode);
}
