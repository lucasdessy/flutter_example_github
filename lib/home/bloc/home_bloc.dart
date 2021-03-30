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
      yield await reloadUsers(event);
    }
    if (event is HomeReloadEvend) {
      add(event.lastEvent);
    }
  }

  @override
  void onTransition(Transition<HomeEvent, HomeState> transition) {
    super.onTransition(transition);
  }

  Future<HomeState> reloadUsers(SearchHomeEvent event) async {
    try {
      final users = await githubRepository.fetchUsers(event.searchTerms);
      if (users.items != null) {
        return HomeLoaded(users.items!);
      }
      return HomeEmpty();
    } catch (e) {
      return HomeError(lastEvent: event);
    }
  }
}
