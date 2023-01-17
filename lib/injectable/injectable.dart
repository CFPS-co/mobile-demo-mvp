import 'package:cfps/injectable/injectable.config.dart';
import 'package:cfps/main/flavors/flavor_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void injectDependencies() => getIt.init(environment: FlavorConfig.instance.flavor.name);
