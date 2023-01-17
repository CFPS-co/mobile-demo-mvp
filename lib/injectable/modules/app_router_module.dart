import 'package:cfps/app/utils/router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppRouterModule {
  @singleton
  AppRouter get instance => AppRouter();
}
