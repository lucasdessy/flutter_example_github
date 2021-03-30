import 'package:flutter/material.dart';
import 'package:flutter_example_github/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';
import 'package:flutter_example_github/user/user.dart';

class HomeForm extends StatelessWidget {
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          onSubmitted: (value) =>
              context.read<HomeBloc>().add(SearchHomeEvent(value)),
          decoration: InputDecoration(
            labelText: 'pesquise usuários',
            helperText: '',
          ),
        ),
        BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoading) {
              return _buildLoading();
            }
            if (state is HomeError) {
              final lastEvent = state.lastEvent;
              return _buildError(context, lastEvent);
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
        ),
      ],
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildError(BuildContext context, HomeEvent event) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ocorreu um erro'),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(HomeReloadEvend(lastEvent: event));
            },
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
      child: InkWell(
        onTap: () {
          if (user.login != null) {
            Navigator.of(context).push(UserPage.route(userId: user.login!));
          }
        },
        child: Ink(
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
      ),
    );
  }
}
