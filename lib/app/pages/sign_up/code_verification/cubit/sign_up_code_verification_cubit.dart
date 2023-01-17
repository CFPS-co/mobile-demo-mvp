import 'package:bloc/bloc.dart';
import 'package:cfps/domain/entities/sign_up_arguments.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_code_verification_state.dart';

part 'sign_up_code_verification_cubit.freezed.dart';

@injectable
class SignUpCodeVerificationCubit extends Cubit<SignUpCodeVerificationState> {
  SignUpCodeVerificationCubit()
      : super(const SignUpCodeVerificationState.initial());

  int attempts = 0;

  void verifyCode({
    required SignUpArguments arguments,
    required String enteredCode,
  }) {
    attempts++;
    if (attempts >= 3) {
      emit(const SignUpCodeVerificationState.tooManyAttempts());
    } else {
      emit(const SignUpCodeVerificationState.initial());
      arguments.verificationCode == enteredCode
          ? emit(SignUpCodeVerificationState.onSuccess(arguments: arguments))
          : emit(const SignUpCodeVerificationState.codeMismatch());
    }
  }
}
