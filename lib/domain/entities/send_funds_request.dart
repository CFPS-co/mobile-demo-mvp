import 'package:cfps/data/dto/request/mvp_demo/send_funds_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_funds_request.freezed.dart';

@freezed
class SendFundsRequest with _$SendFundsRequest {
  const factory SendFundsRequest({
    required String clientId,
    required String password,
  }) = _SendFundsRequest;
}

extension SendFundsRequestExt on SendFundsRequest {
  SendFundsRequestDto get toDto => SendFundsRequestDto(clientId: clientId, password: password);
}
