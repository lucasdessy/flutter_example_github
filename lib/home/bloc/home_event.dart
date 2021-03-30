part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchHomeEvent extends HomeEvent {
  final String searchTerms;

  SearchHomeEvent(this.searchTerms);

  @override
  String toString() => 'SearchHomeEvent(searchTerms: $searchTerms)';
}

class HomeReloadEvend extends HomeEvent {
  final HomeEvent lastEvent;

  HomeReloadEvend({required this.lastEvent});

  @override
  String toString() => 'HomeReloadEvend(lastEvent: $lastEvent)';
}
