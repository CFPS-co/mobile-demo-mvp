import 'package:cfps/domain/data_source/mvp_api_data_source.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'mvp_api_data_source_impl.g.dart';

@RestApi()
abstract class MvpApiDataSourceImpl implements MvpApiDataSource {
  factory MvpApiDataSourceImpl(Dio dio, {String baseUrl}) = _MvpApiDataSourceImpl;
  @MultiPart()
  @POST('send_verification')
  @override
  Future<HttpResponse> checkEmail(@Part() String email);

  @MultiPart()
  @POST('make_transaction')
  @override
  Future<HttpResponse> sendFunds(
    @Part(name: 'client_id') String clientId,
    @Part() String password,
  );

  @MultiPart()
  @POST('client_login')
  @override
  Future<HttpResponse> signIn(
    @Part() String email,
    @Part() String password,
  );
}
