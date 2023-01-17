import 'package:cfps/data/data_source/mvp_api_data_source_impl.dart';
import 'package:cfps/domain/data_source/mvp_api_data_source.dart';
import 'package:cfps/main/flavors/flavor_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../app/utils/consts.dart';
import '../../data/data_source/retrofit_api_data_source_impl.dart';
import '../../domain/data_source/retrofit_api_data_source.dart';
import '../../domain/utils/interceptors/pretty_dio_logger_interceptor.dart';

@module
abstract class ApiModule {
  @injectable
  Dio get client => Dio(
        BaseOptions(
          baseUrl: '', //TODO: To be determined
          contentType: defaultContentType,
        ),
      )..interceptors.addAll([
          prettyDioLogger,
          // DioFirebasePerformanceInterceptor(), //TODO: Not supported yet
          // AuthErrorInterceptor(), //TODO: Not supported yet
        ]);

  RetrofitApiDataSource apiDataSource(Dio dio) => RetrofitApiDataSourceImpl(
        dio,
        baseUrl: '', //TODO: To be determined
      );

  MvpApiDataSource mvpApiDataSource(Dio dio) => MvpApiDataSourceImpl(
        dio,
        baseUrl: FlavorConfig.instance.apiUrl,
      );
}
