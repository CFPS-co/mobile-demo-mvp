import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_funds_response.freezed.dart';

@freezed
class SendFundsResponse with _$SendFundsResponse {
  const factory SendFundsResponse({
    required String status,
  }) = _SendFundsResponse;
}
