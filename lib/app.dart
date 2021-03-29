import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';
import 'package:flutter_example_github/splash/splash.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.githubRepository}) : super(key: key);

  final GithubRepository githubRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GithubRepository>.value(
      value: githubRepository,
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: (_) => SplashPage.route());
  }
}
