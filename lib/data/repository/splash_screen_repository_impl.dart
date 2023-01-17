import 'package:cfps/domain/repository/splash_screen_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashScreenRepository)
class SplashScreenRepositoryImpl implements SplashScreenRepository {
  @override
  void removeSplashScreen() {
    try {
      FlutterNativeSplash.remove();
    } catch (e) {
      return;
    }
  }
}
