part of 'home_bloc.dart';

class HomeState {
  final List<GIF> gifList;

  HomeState(this.gifList);
}

class LoadingState extends HomeState {
  LoadingState(super.gifList);
}

class DataLoadedState extends HomeState {
  DataLoadedState(super.gifList);
}

class SearchingNewPageState extends HomeState {
  SearchingNewPageState(super.gifList);
}

class SearchingGifsState extends HomeState {
  SearchingGifsState(super.gifList);
}

class ErrorState extends HomeState {
  final String errorMessage;

  ErrorState(super.gifList,{required this.errorMessage});
}
