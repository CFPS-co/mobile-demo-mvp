import 'package:bloc/bloc.dart';
import 'package:cfps/data/data_source/mvp_local_data_source_impl.dart';
import 'package:cfps/domain/entities/client_details.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

part 'profile_cubit.freezed.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.mvpLocalDataSource,
    this.mvpDemoRepository,
  ) : super(const ProfileState.initial()) {
    init();
  }

  final MvpLocalDataSource mvpLocalDataSource;
  final MvpDemoRepository mvpDemoRepository;

  Future<void> init() async {
    emit(const ProfileState.loading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await mvpDemoRepository.getClientDetails();

    result.fold(
      (l) => emit(ProfileState.failure(l)),
      (r) => emit(ProfileState.loaded(clientDetails: r)),
    );
  }

  Future<void> logout() async {
    await mvpLocalDataSource.deleteClientId();
    await mvpLocalDataSource.deleteEmail();
    await mvpLocalDataSource.deletePassword();
    await mvpLocalDataSource.deletePin();
    emit(const ProfileState.logout());
  }
}
