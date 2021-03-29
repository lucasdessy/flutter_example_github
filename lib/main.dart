import 'package:flutter/material.dart';
import 'package:flutter_example_github/app.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

void main() {
  runApp(App(githubRepository: GithubRepository()));
}
