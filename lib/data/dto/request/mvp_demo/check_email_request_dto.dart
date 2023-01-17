import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_email_request_dto.freezed.dart';

part 'check_email_request_dto.g.dart';

@freezed
class CheckEmailRequestDto with _$CheckEmailRequestDto {
  const factory CheckEmailRequestDto({
    required String email,
  }) = CheckEmailRequestDtoData;

  factory CheckEmailRequestDto.fromJson(Map<String, dynamic> json) => _$CheckEmailRequestDtoFromJson(json);
}
