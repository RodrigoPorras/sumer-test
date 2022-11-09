import 'package:sumer_test/data/models/gif_request.dart';

abstract class MainRepository {
  Future<TrendingGIFsRequest> getTrendingList({int? limit, int? offset});
  Future<TrendingGIFsRequest> searchGifs({String? q, int? limit, int? offset});
}
