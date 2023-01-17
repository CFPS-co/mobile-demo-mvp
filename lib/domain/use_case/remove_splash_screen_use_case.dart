import 'package:cfps/domain/repository/splash_screen_repository.dart';
import 'package:cfps/domain/utils/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveSplashScreenUseCase implements NoParamUseCaseSimple<void> {
  RemoveSplashScreenUseCase(this.splashScreenRepository);

  final SplashScreenRepository splashScreenRepository;

  @override
  void call() => splashScreenRepository.removeSplashScreen();
}
