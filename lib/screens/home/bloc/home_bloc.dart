import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumer_test/data/models/gif.dart';
import 'package:sumer_test/data/repository/main/main_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MainRepository mainRepository;

  HomeBloc({required this.mainRepository}) : super(HomeState([])) {
    on<StartedEvent>(_startedEventToState);
    on<SearchNextPageEvent>(_searchNextPageEventToState);
    on<SearchGifsWithQueryEvent>(_searchGifsWithQueryEventToState);
  }

  _startedEventToState(
    StartedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingState([]));
    try {
      final trendindListRequest = await mainRepository.getTrendingList();
      emit(DataLoadedState(trendindListRequest.gifList));
    } catch (e) {
      emit(ErrorState(state.gifList, errorMessage: e.toString()));
    }
  }

  _searchNextPageEventToState(
    SearchNextPageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(SearchingNewPageState(state.gifList));
    try {
      final trendindListRequest = event.thereIsAQuery
          ? await mainRepository.searchGifs(q: event.currentQuery)
          : await mainRepository.getTrendingList(offset: state.gifList.length);

      final newGifList = <GIF>[
        ...state.gifList,
        ...trendindListRequest.gifList
      ];
      emit(DataLoadedState(newGifList));
    } catch (e) {
      emit(ErrorState(state.gifList, errorMessage: e.toString()));
    }
  }

  _searchGifsWithQueryEventToState(
    SearchGifsWithQueryEvent event,
    Emitter<HomeState> emit,
  ) async {
    if(event.query.isEmpty){
      add(StartedEvent());
      return;
    }
    emit(SearchingGifsState(state.gifList));
    try {
      final trendindListRequestWithQuery =
          await mainRepository.searchGifs(q: event.query);

      emit(DataLoadedState(trendindListRequestWithQuery.gifList));
    } catch (e) {
      emit(ErrorState(state.gifList, errorMessage: e.toString()));
    }
  }
}
