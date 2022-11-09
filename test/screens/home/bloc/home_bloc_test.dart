import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sumer_test/data/models/gif_request.dart';
import 'package:sumer_test/data/repository/main/main_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:sumer_test/screens/home/home.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  MainRepository,
])
void main() {
  group(
    'HomeBloc',
    () {
      late HomeBloc homeBloc;

      final mockMainRepository = MockMainRepository();

      setUp(
        () {
          homeBloc = HomeBloc(mainRepository: mockMainRepository);
        },
      );

      blocTest(
        'When StartedEvent starts and there is no error in endpoint LoadingState and DataLoadedState must triggered',
        setUp: () {
          when(mockMainRepository.getTrendingList()).thenAnswer(
            (realInvocation) async => TrendingGIFsRequest(
              gifList: [],
              pagination: Pagination(totalCount: 0, count: 0, offset: 0),
              meta: Meta(msg: '', responseId: '', status: 0),
            ),
          );
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(StartedEvent()),
        expect: () => [
          isA<LoadingState>(),
          isA<DataLoadedState>(),
        ],
      );

      blocTest(
        'When StartedEvent starts and there an error in endpoint LoadingState and ErrorState must triggered',
        setUp: () {
          when(mockMainRepository.getTrendingList()).thenThrow(
              DioError(requestOptions: RequestOptions(path: 'path')));
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(StartedEvent()),
        expect: () => [
          isA<LoadingState>(),
          isA<ErrorState>(),
        ],
      );

      blocTest(
        'When SearchNextPageEvent starts,SearchNextPageEvent.thereIsAQuery is false and there is not an error in endpoint SearchingNewPageState and DataLoadedState must triggered',
        setUp: () {
          when(mockMainRepository.getTrendingList(offset: anyNamed("offset")))
              .thenAnswer(
            (realInvocation) async => TrendingGIFsRequest(
              gifList: [],
              pagination: Pagination(totalCount: 0, count: 0, offset: 0),
              meta: Meta(msg: '', responseId: '', status: 0),
            ),
          );
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(SearchNextPageEvent()),
        expect: () => [
          isA<SearchingNewPageState>(),
          isA<DataLoadedState>(),
        ],
      );

      blocTest(
        'When SearchNextPageEvent starts,SearchNextPageEvent.thereIsAQuery is false and there is an error in endpoint SearchingNewPageState and ErrorState must triggered',
        setUp: () {
          when(mockMainRepository.getTrendingList(offset: anyNamed("offset"))).thenThrow(
              DioError(requestOptions: RequestOptions(path: '')));
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(SearchNextPageEvent(thereIsAQuery: false)),
        expect: () => [
          isA<SearchingNewPageState>(),
          isA<ErrorState>(),
        ],
      );

      blocTest(
        'When SearchNextPageEvent starts,SearchNextPageEvent.thereIsAQuery is true and there is not an error in endpoint SearchingNewPageState and DataLoadedState must triggered',
        setUp: () {
          when(mockMainRepository.searchGifs(offset: anyNamed("offset")))
              .thenAnswer(
            (realInvocation) async => TrendingGIFsRequest(
              gifList: [],
              pagination: Pagination(totalCount: 0, count: 0, offset: 0),
              meta: Meta(msg: '', responseId: '', status: 0),
            ),
          );
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) =>
            bloc.add(SearchNextPageEvent(thereIsAQuery: true)),
        expect: () => [
          isA<SearchingNewPageState>(),
          isA<DataLoadedState>(),
        ],
      );

      blocTest(
        'When SearchNextPageEvent starts,SearchNextPageEvent.thereIsAQuery is true and there is an error in endpoint SearchingNewPageState and ErrorState must triggered',
        setUp: () {
          when(mockMainRepository.searchGifs()).thenThrow(
              DioError(requestOptions: RequestOptions(path: 'path')));
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) =>
            bloc.add(SearchNextPageEvent(thereIsAQuery: true)),
        expect: () => [
          isA<SearchingNewPageState>(),
          isA<ErrorState>(),
        ],
      );

      blocTest(
        'When SearchGifsWithQueryEvent starts,SearchGifsWithQueryEvent.query.isNotEmpty is true and there is not an error in endpoint SearchingNewPageState and DataLoadedState must triggered',
        setUp: () {
          when(mockMainRepository.searchGifs(q: anyNamed("q"))).thenAnswer(
            (realInvocation) async => TrendingGIFsRequest(
              gifList: [],
              pagination: Pagination(totalCount: 0, count: 0, offset: 0),
              meta: Meta(msg: '', responseId: '', status: 0),
            ),
          );
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(SearchGifsWithQueryEvent('q')),
        expect: () => [
          isA<SearchingGifsState>(),
          isA<DataLoadedState>(),
        ],
      );
      blocTest(
        'When SearchGifsWithQueryEvent starts,SearchGifsWithQueryEvent.query.isNotEmpty is false LoadingState and DataLoadedState from StartedEvent must be called',
        setUp: () {
          when(mockMainRepository.getTrendingList()).thenAnswer(
            (realInvocation) async => TrendingGIFsRequest(
              gifList: [],
              pagination: Pagination(totalCount: 0, count: 0, offset: 0),
              meta: Meta(msg: '', responseId: '', status: 0),
            ),
          );
        },
        build: () => homeBloc,
        act: (HomeBloc bloc) => bloc.add(SearchGifsWithQueryEvent('')),
        expect: () => [
          isA<LoadingState>(),
          isA<DataLoadedState>(),
        ],
      );
    },
  );
}
