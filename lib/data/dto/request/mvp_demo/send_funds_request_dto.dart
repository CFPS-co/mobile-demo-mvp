import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_funds_request_dto.freezed.dart';

part 'send_funds_request_dto.g.dart';

@freezed
class SendFundsRequestDto with _$SendFundsRequestDto {
  const factory SendFundsRequestDto({
    required String clientId,
    required String password,
  }) = SendFundsRequestDtoData;

  factory SendFundsRequestDto.fromJson(Map<String, dynamic> json) => _$SendFundsRequestDtoFromJson(json);
}
