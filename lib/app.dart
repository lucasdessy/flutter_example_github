import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';
import 'package:flutter_example_github/splash/splash.dart';
import 'package:flutter_example_github/home/home.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.githubRepository}) : super(key: key);

  final GithubRepository githubRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GithubRepository>.value(
      value: githubRepository,
      child: BlocProvider<SplashCubit>(
        create: (_) => SplashCubit(),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            switch (state) {
              case SplashState.unloaded:
                break;
              case SplashState.loaded:
                _navigator.pushAndRemoveUntil(
                    HomePage.route(), (route) => false);
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
