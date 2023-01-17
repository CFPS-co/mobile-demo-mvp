import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/data_source/retrofit_api_data_source.dart';


part 'retrofit_api_data_source_impl.g.dart';

@RestApi()
abstract class RetrofitApiDataSourceImpl implements RetrofitApiDataSource {
  factory RetrofitApiDataSourceImpl(Dio dio, {String baseUrl}) = _RetrofitApiDataSourceImpl;


}
