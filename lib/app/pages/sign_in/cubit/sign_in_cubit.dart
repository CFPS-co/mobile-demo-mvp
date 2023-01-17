import 'package:bloc/bloc.dart';
import 'package:cfps/domain/entities/request/sign_in_request.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/errors.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._mvpDemoRepository) : super(const SignInState.initial());

  final MvpDemoRepository _mvpDemoRepository;

  Future signIn(String email, String password) async {
    emit(const SignInState.initial());
    final request = SignInRequest(
      email: email,
      password: password,
    );

    final result = await _mvpDemoRepository.signIn(request);

    result.fold(
      (l) {
        if (l.error == Errors.apiWrongPassword) {
          emit(const SignInState.wrongPassword());
        } else if (l.error == Errors.apiClientNotExist) {
          emit(const SignInState.userNotExist());
        } else {
          emit(SignInState.error(l));
        }
      },
      (r) => emit(
        const SignInState.success(),
      ),
    );
  }
}
