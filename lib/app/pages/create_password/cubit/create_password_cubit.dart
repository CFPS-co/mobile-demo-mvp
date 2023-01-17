import 'package:bloc/bloc.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_password_state.dart';

part 'create_password_cubit.freezed.dart';

@injectable
class CreatePasswordCubit extends Cubit<CreatePasswordState> {
  CreatePasswordCubit(this.mvpDemoRepository) : super(const CreatePasswordState.initial());

  final MvpDemoRepository mvpDemoRepository;

  Future<void> saveCredentials(String password, String email) async {
    emit(const CreatePasswordState.loading());
    final registerResult = await mvpDemoRepository.clientRegister(email, password);
    registerResult.fold(
      (fail) => emit(CreatePasswordState.fail(fail)),
      (success) => emit(const CreatePasswordState.saved()),
    );
  }
}
