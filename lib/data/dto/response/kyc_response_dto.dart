import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_response_dto.freezed.dart';
part 'kyc_response_dto.g.dart';

@freezed
class KycResponseDto with _$KycResponseDto {
  const factory KycResponseDto({
    @JsonKey(name: "sumsubtoken") required String sumsubToken,
    @JsonKey(name: "client_id") required String clientId,
  }) = _KycResponseDto;

  factory KycResponseDto.fromJson(Map<String, dynamic> json) => _$KycResponseDtoFromJson(json);
}
