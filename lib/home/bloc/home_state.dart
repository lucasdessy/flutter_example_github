part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final HomeEvent lastEvent;

  HomeError({required this.lastEvent});

  @override
  String toString() => 'HomeError(lastEvent: $lastEvent)';
}

class HomeEmpty extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Item> items;

  HomeLoaded(this.items);

  @override
  String toString() => 'HomeLoaded(items: $items)';
}
