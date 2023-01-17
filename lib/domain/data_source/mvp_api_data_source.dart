import 'package:retrofit/dio.dart';

abstract class MvpApiDataSource {
  Future<HttpResponse> checkEmail(String email);

  Future<HttpResponse> sendFunds(String clientId, String password);

  Future<HttpResponse> signIn(String email, String password);
}
