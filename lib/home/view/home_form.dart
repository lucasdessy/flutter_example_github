import 'package:flutter/material.dart';
import 'package:flutter_example_github/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) =>
          context.read<HomeBloc>().add(SearchHomeEvent(value)),
      decoration: InputDecoration(
        labelText: 'pesquise usuários',
        helperText: '',
      ),
    );
  }
}
