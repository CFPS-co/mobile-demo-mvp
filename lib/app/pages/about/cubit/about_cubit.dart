import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_state.dart';
part 'about_cubit.freezed.dart';

@injectable
class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(const AboutState.initial()) {
    init();
  }

  void init() async {
    emit(const AboutState.loading());
    final packageInfo = await PackageInfo.fromPlatform();
    emit(AboutState.loaded(version: "${packageInfo.version} (${packageInfo.buildNumber})"));
  }
}
