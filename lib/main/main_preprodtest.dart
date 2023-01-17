import 'package:cfps/main/flavors/flavor.dart';
import 'package:cfps/main/flavors/flavor_config.dart';
import 'package:cfps/main/main.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.preprodtest,
    name: "",
    bundleID: '',
    appID: '',
    apiUrl: '',
  );

  mainCommon();
}
