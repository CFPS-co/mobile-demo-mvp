import 'package:bloc/bloc.dart';
import 'package:cfps/app/pages/login_with_pin_code/utils/login_with_pin_code_type.dart';
import 'package:cfps/app/utils/consts.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_with_pin_code_cubit.freezed.dart';

part 'login_with_pin_code_state.dart';

@injectable
class LoginWithPinCodeCubit extends Cubit<LoginWithPinCodeState> {
  LoginWithPinCodeCubit(this._mvpDemoRepository, @factoryParam this.loginType)
      : super(const LoginWithPinCodeState.auth()) {
    init();
  }

  final MvpDemoRepository _mvpDemoRepository;
  final LoginWithPinType loginType;
  String? firstPinCode;

  void init() {
    switch (loginType) {
      case LoginWithPinType.auth:
        emit(const LoginWithPinCodeState.auth());
        break;
      case LoginWithPinType.changePin:
        emit(const LoginWithPinCodeState.auth());
        break;
      case LoginWithPinType.setPin:
        initSetPin();
        break;
    }
  }

  void onCodeEntered(String code) {
    state.whenOrNull(
      auth: (authError) async {
        switch (loginType) {
          case LoginWithPinType.auth:
            await startAuth(code);
            break;
          case LoginWithPinType.changePin:
            startPinSet(code, isChangePin: true);
            break;
          case LoginWithPinType.setPin:
            startPinSet(code);
            break;
        }
      },
      setPin: () => onFirstPinCodeSet(code),
      confirmPin: () => onPinConfirmed(code),
    );
  }

  Future startAuth(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await onAuthPinEntered(code)
        ? emit(const LoginWithPinCodeState.onSuccess())
        : emit(const LoginWithPinCodeState.auth(authError: true));
  }

  Future<bool> onAuthPinEntered(String code) async {
    final savedCode = await getSavedPinCode();
    return savedCode == code;
  }

  void startPinSet(String code, {bool isChangePin = false}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    isChangePin
        ? await onAuthPinEntered(code)
            ? emit(const LoginWithPinCodeState.setPin())
            : emit(const LoginWithPinCodeState.auth(authError: true))
        : emit(const LoginWithPinCodeState.setPin());
  }

  void onFirstPinCodeSet(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));

    firstPinCode = code;
    emit(const LoginWithPinCodeState.confirmPin());
  }

  void onPinConfirmed(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final savedCode = await getSavedPinCode();

    if (code == savedCode && code == firstPinCode) {
      /// Check if new pin is same as current
      emit(const LoginWithPinCodeState.newPinSameAsCurrent());
    } else if (code == firstPinCode) {
      /// Check if both new pins are the same
      await savePinCode(code);
      emit(const LoginWithPinCodeState.onSuccess());
    } else {
      emit(const LoginWithPinCodeState.pinsDontMatch());
    }
  }

  Future savePinCode(String code) async {
    _mvpDemoRepository.savePin(code);
  }

  Future<String?> getSavedPinCode() async {
    final result = _mvpDemoRepository.getPin();
    return result.fold(
      (l) => null,
      (r) => r,
    );
  }

  void initSetPin() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(pinStorageKey);
    emit(const LoginWithPinCodeState.setPin());
  }

  void reset(LoginWithPinType loginType) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    switch (loginType) {
      case LoginWithPinType.auth:
        emit(const LoginWithPinCodeState.auth());
        break;
      case LoginWithPinType.changePin:
        emit(const LoginWithPinCodeState.setPin());
        break;
      case LoginWithPinType.setPin:
        emit(const LoginWithPinCodeState.setPin());
        break;
    }
  }
}
