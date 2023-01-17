import 'package:bloc/bloc.dart';
import 'package:cfps/domain/entities/client_details.dart';
import 'package:cfps/domain/repository/mvp_demo_repository.dart';
import 'package:cfps/domain/utils/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_state.dart';

part 'dashboard_cubit.freezed.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.mvpDemoRepository) : super(const DashboardState.initial()) {
    load();
  }

  final MvpDemoRepository mvpDemoRepository;

  Future<void> load() async {
    emit(const DashboardState.loading());
    final details = await mvpDemoRepository.getClientDetails();

    details.fold(
      (l) => emit(const DashboardState.error()),
      (r) => emit(DashboardState.loaded(details: r)),
    );
  }
}
