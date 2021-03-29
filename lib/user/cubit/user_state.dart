part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}
