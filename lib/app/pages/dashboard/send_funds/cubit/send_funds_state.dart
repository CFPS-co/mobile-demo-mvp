part of 'send_funds_cubit.dart';

@freezed
class SendFundsState with _$SendFundsState {
  const factory SendFundsState.initial() = _Initial;
  const factory SendFundsState.loading() = _Loading;

  const factory SendFundsState.loaded({
    double? amount,
    ValidationError? amountValidator,
  }) = _SendFundsState;

  const factory SendFundsState.amountCorrect() = _AmountCorrect;
  const factory SendFundsState.transferSuccess() = _TransferSuccess;

  const factory SendFundsState.onSuccess({required String status, required String clientId, required String password}) =
      _OnSuccess;

  const factory SendFundsState.onError() = _OnError;

  const factory SendFundsState.userNotExist() = _UserNotExist;
}
