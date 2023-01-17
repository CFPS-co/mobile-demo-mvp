import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/data_source/retrofit_api_data_source.dart';
import '../../domain/repository/api_repository.dart';

@Injectable(as: ApiRepository)
class ApiRepositoryImpl implements ApiRepository {
  ApiRepositoryImpl(this._retrofitApiDataSource, this._dio);

  final RetrofitApiDataSource _retrofitApiDataSource;
  final Dio _dio;

  bool _has2xxStatus(HttpResponse result) => result.response.statusCode! > 199 && result.response.statusCode! < 300;
}
