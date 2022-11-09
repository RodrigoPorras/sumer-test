import 'package:sumer_test/data/models/gif_request.dart';
import 'package:sumer_test/data/remote/providers/main_api_provider.dart';
import 'package:sumer_test/data/repository/main/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainApiProvider _mainApiProvider;

  MainRepositoryImpl(this._mainApiProvider);

  @override
  Future<TrendingGIFsRequest> getTrendingList({int? limit, int? offset}) {
    return _mainApiProvider.getTrendingList(limit: limit, offset: offset);
  }

  @override
  Future<TrendingGIFsRequest> searchGifs({String? q, int? limit, int? offset}) {
    return _mainApiProvider.searchGifs(q: q, limit: limit, offset: offset);
  }
}
