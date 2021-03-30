part of 'repo_cubit.dart';

@immutable
abstract class RepoState {}

class RepoLoading extends RepoState {}

class RepoError extends RepoState {}

class RepoLoaded extends RepoState {
  final List<Repo> repos;

  RepoLoaded(this.repos);
}
