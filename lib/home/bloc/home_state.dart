part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeEmpty extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Item> items;

  HomeLoaded(this.items);
}
