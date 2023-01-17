import 'package:bloc/bloc.dart';
import 'package:cfps/app/utils/enums/validators.dart';
import 'package:cfps/data/data_source/mvp_local_data_source_impl.dart';
import 'package:cfps/domain/entities/send_funds_request.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/use_case/send_funds_use_case.dart';
import 'package:cfps/domain/utils/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'send_funds_state.dart';

part 'send_funds_cubit.freezed.dart';

@injectable
class SendFundsCubit extends Cubit<SendFundsState> {
  SendFundsCubit(this._sendFundsUseCase, this.mvpDemoRepository, this.mvpLocalDataSource)
      : super(const SendFundsState.loaded(
          amount: 0.0,
        ));

  // static const username = "TSRMDpOo4A";
  // static const password = "sfdgdfg5464567dfg";

  final SendFundsUseCase _sendFundsUseCase;
  final MvpDemoRepository mvpDemoRepository;
  final MvpLocalDataSource mvpLocalDataSource;

  double? _amount;
  double? _accountBalance;
  double? _requiredAmount;

  Future sendFunds(String clientId, String password) async {
    final request = SendFundsRequest(clientId: clientId, password: password);
    final result = await _sendFundsUseCase.call(request);

    result.fold(
      (failure) {
        failure.error == Errors.apiClientNotExist
            ? emit(const SendFundsState.userNotExist())
            : emit(const SendFundsState.onError());

        emit(const SendFundsState.initial());
      },
      (success) => emit(SendFundsState.onSuccess(
        status: success.status,
        clientId: clientId,
        password: password,
      )),
    );
  }

  void updateDate({required double amount, required double accountbalance, required double requiredAmount}) {
    _amount = amount;
    _accountBalance = accountbalance;
    _requiredAmount = requiredAmount;

    validate();
  }

  bool validate() {
    ValidationError? validator;

    if (_amount == null) {
      validator = ValidationError.fieldIsRequired;
    }

    if (_amount != null && _accountBalance != null && _amount! < _requiredAmount!) {
      validator = ValidationError.amountTooShort;
    }

    if (_amount != null && _accountBalance != null && _amount! < _accountBalance!) {
      validator = ValidationError.amountTooShort;
    }

    if (_amount != null && _accountBalance != null && _amount! > _accountBalance!) {
      validator = ValidationError.amountTooHigh;
    }

    emit(
      SendFundsState.loaded(amountValidator: validator),
    );

    return validator == null ? true : false;
  }

  void buttonPressed() async {
    if (validate()) {
      emit(const SendFundsState.amountCorrect());
      // ! mocked values
      final clientId = mvpLocalDataSource.getClientId();
      final password = mvpLocalDataSource.getPassword();

      if (clientId != null && password != null) {
        await sendFunds(clientId, password);
      }

      emit(const SendFundsState.transferSuccess());
    }
  }
}
