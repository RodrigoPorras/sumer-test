import 'package:dio/dio.dart';
import 'package:sumer_test/data/models/gif_request.dart';
import 'package:sumer_test/data/remote/url_paths.dart';
import 'package:sumer_test/settings/logger.dart';

const apiKey = "RBoidm8kPxDWXOCcqf3cwxiYMNSXFnzu";

class MainApiProvider {
  final Dio dio;

  MainApiProvider(this.dio);

  Future<TrendingGIFsRequest> getTrendingList(
      {int? limit = 25, int? offset}) async {
    try {
      final params = {
        "api_key": apiKey,
        "limit": limit,
        "offset": offset,
      };

      final result = await dio.get(
        UrlPaths.gifTrending,
        queryParameters: params,
      );

      return TrendingGIFsRequest.fromJson(result.data);
    } catch (e, stack) {
      Log.to.e(stack.toString());
      rethrow;
    }
  }

  Future<TrendingGIFsRequest> searchGifs(
      {String? q, int? limit = 25, int? offset}) async {
    try {
      final params = {
        "api_key": apiKey,
        "q": q,
        "limit": limit,
        "offset": offset,
      };

      final result = await dio.get(
        UrlPaths.gifSearch,
        queryParameters: params,
      );

      return TrendingGIFsRequest.fromJson(result.data);
    } catch (e, stack) {
      Log.to.e(stack.toString());
      rethrow;
    }
  }
}
