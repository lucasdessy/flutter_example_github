part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchHomeEvent extends HomeEvent {
  final String searchTerms;

  SearchHomeEvent(this.searchTerms);
}
