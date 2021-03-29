import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_example_github/home/home.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) =>
              HomeBloc(githubRepository: context.read<GithubRepository>()),
          child: HomeForm(),
        ),
      ),
    );
  }
}
