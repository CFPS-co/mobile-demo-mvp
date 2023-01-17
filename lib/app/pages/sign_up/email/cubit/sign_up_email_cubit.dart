import 'package:bloc/bloc.dart';
import 'package:cfps/domain/use_case/check_email_use_case.dart';
import 'package:cfps/domain/utils/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entities/request/check_email_request.dart';

part 'sign_up_email_state.dart';

part 'sign_up_email_cubit.freezed.dart';

@injectable
class SignUpEmailCubit extends Cubit<SignUpEmailState> {
  SignUpEmailCubit(this._checkEmailUseCase) : super(const SignUpEmailState.initial());

  final CheckEmailUseCase _checkEmailUseCase;

  Future checkEmail(String email) async {
    final request = CheckEmailRequest(email: email);
    final result = await _checkEmailUseCase.call(request);

    result.fold(
      (failure) {
        failure.error == Errors.apiClientAlreadyRegistered
            ? emit(const SignUpEmailState.clientAlreadyRegistered())
            : emit(const SignUpEmailState.onError());

        emit(const SignUpEmailState.initial());
      },
      (success) => emit(SignUpEmailState.onSuccess(verificationCode: success.verificationCode, email: email)),
    );
  }
}
