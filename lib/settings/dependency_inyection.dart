import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sumer_test/data/remote/providers/main_api_provider.dart';
import 'package:sumer_test/data/repository/main/main_repository.dart';
import 'package:sumer_test/data/repository/main/main_repository_impl.dart';

final getIt = GetIt.instance;

setupDependencyInjection() {
  final dioClient = _provideDio();
  getIt.registerSingleton<Dio>(dioClient);
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<MainRepository>(
    MainRepositoryImpl(
      MainApiProvider(dioClient),
    ),
  );
}

Dio _provideDio() {
  final dio = Dio()
    ..options.baseUrl = 'http://'
    ..options.connectTimeout = 30000
    ..options.receiveTimeout = 30000;
  return dio;
}
