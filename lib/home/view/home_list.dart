import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_github/home/home.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildLoading();
        }
        if (state is HomeError) {
          return _buildError(context);
        }

        if (state is HomeLoaded) {
          return _buildList(state.items);
        }

        if (state is HomeEmpty) {
          return _buildEmpty();
        }

        // HomeInitial
        return Container();
      },
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildError(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ocorreu um erro'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Tentar novamente'),
          ),
        ],
      );

  Widget _buildList(List<Item> items) => Expanded(
        child: ListView(
          shrinkWrap: true,
          children: items
              .map(
                (e) => _UserTile(user: e),
              )
              .toList(),
        ),
      );

  Widget _buildEmpty() => Center(
        child: Text('Não há nenhum resultado disponível'),
      );
}

class _UserTile extends StatelessWidget {
  final Item user;

  const _UserTile({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('${user.login}'),
            leading: CircleAvatar(
              foregroundImage: NetworkImage('${user.avatarUrl}'),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
