part of 'home_bloc.dart';

abstract class HomeEvent {}

class StartedEvent extends HomeEvent {}

class SearchNextPageEvent extends HomeEvent {
  final bool thereIsAQuery;
  final String? currentQuery;

  SearchNextPageEvent({this.thereIsAQuery = false,this.currentQuery});
}

class SearchGifsWithQueryEvent extends HomeEvent {
  final String query;

  SearchGifsWithQueryEvent(this.query);
}
