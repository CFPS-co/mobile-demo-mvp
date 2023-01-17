import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MvpLocalDataSource {
  Future<void> savePin(String code);

  String? getPin();

  Future<void> deletePin();

  Future<void> savePassword(String password);

  String? getPassword();

  Future<void> deletePassword();

  Future<void> saveEmail(String email);

  String? getEmail();

  Future<void> deleteEmail();

  Future<void> saveClientId(String clientId);

  String? getClientId();

  Future<void> deleteClientId();
}

@Injectable(as: MvpLocalDataSource)
class MvpLocalDataSourceImpl implements MvpLocalDataSource {
  MvpLocalDataSourceImpl(this.preferences);

  final SharedPreferences preferences;

  static const _passwordKey = "_passwordKey";
  static const _emailKey = "_emailKey";
  static const _pinKey = "_pinKey";
  static const _clientId = "_clientId";

  @override
  Future<void> deleteEmail() => _deleteRemove(_emailKey);

  @override
  Future<void> deletePassword() => _deleteRemove(_passwordKey);

  @override
  Future<void> deletePin() => _deleteRemove(_pinKey);

  @override
  Future<void> saveEmail(String email) => _saveValue(_emailKey, email);

  @override
  Future<void> savePassword(String password) => _saveValue(_passwordKey, password);

  @override
  Future<void> savePin(String code) => _saveValue(_pinKey, code);

  @override
  String? getPin() => _getValue(_pinKey);

  @override
  String? getEmail() => _getValue(_emailKey);

  @override
  String? getPassword() => _getValue(_passwordKey);

  @override
  Future<void> deleteClientId() => _deleteRemove(_clientId);

  @override
  String? getClientId() => _getValue(_clientId);

  @override
  Future<void> saveClientId(String clientId) => _saveValue(_clientId, clientId);

  String? _getValue(String key) => preferences.getString(key);

  Future<void> _deleteRemove(String key) => preferences.remove(key);

  Future<void> _saveValue(String key, String value) => preferences.setString(key, value);
}
