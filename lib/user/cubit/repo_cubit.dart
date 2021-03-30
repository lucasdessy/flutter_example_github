import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';
part 'repo_state.dart';

class RepoCubit extends Cubit<RepoState> {
  RepoCubit({required this.githubRepository, required this.userId})
      : super(RepoLoading()) {
    _load();
  }
  final GithubRepository githubRepository;
  final String userId;
  Future<void> _load() async {
    try {
      emit(RepoLoading());
      final repos = await githubRepository.fetchRepos(userId);
      emit(RepoLoaded(repos));
    } catch (e) {
      print(e);
      emit(RepoError());
    }
  }

  void reloadRepos() {
    _load();
  }
}
