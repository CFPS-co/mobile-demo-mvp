import 'package:cfps/main/flavors/flavor.dart';
import 'package:flutter/foundation.dart';

@immutable
class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required String name,
    required String bundleID,
    required String appID,
    required String apiUrl,
  }) {
    _instance ??= FlavorConfig._internal(flavor, name, bundleID, appID, apiUrl);
    return _instance!;
  }

  const FlavorConfig._internal(
    this.flavor,
    this.name,
    this.bundleID,
    this.appID,
    this.apiUrl,
  );

  final Flavor flavor;
  final String name;
  final String bundleID;
  final String appID;
  final String apiUrl;

  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance!;
}
