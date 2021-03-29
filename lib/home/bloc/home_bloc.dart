import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.githubRepository}) : super(HomeInitial());

  final GithubRepository githubRepository;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is SearchHomeEvent) {
      yield HomeLoading();
      yield await reloadUsers(event.searchTerms);
    }
  }

  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    super.onTransition(transition);
  }

  Future<HomeState> reloadUsers(String query) async {
    try {
      final users = await githubRepository.fetchUsers(query);
      if (users.items != null) {
        return HomeLoaded(users.items!);
      }
      return HomeEmpty();
    } catch (e) {
      return HomeError();
    }
  }
}
