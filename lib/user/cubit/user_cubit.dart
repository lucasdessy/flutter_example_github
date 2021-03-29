import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userId, required this.githubRepository})
      : super(UserLoading()) {
    _load(userId);
  }
  final GithubRepository githubRepository;
  final String userId;
  Future<void> _load(String _userId) async {
    try {
      print('loading user $_userId');
      emit(UserLoading());
      final user = await githubRepository.fetchUser(userId);
      print('loaded user $_userId');
      emit(UserLoaded(user));
    } on Exception {
      emit(UserError());
    }
  }

  void reloadUser() {
    _load(userId);
  }
}
