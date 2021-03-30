import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_github/repos/github_repository/github_repository.dart';

import 'package:flutter_example_github/user/user.dart';

class UserPage extends StatelessWidget {
  final String userId;

  const UserPage({Key? key, required this.userId}) : super(key: key);
  static Route route({required String userId}) {
    return MaterialPageRoute(
      builder: (_) => UserPage(
        userId: userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$userId'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserCubit(
                userId: userId,
                githubRepository: context.read<GithubRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => RepoCubit(
                userId: userId,
                githubRepository: context.read<GithubRepository>(),
              ),
            ),
          ],
          child: _UserView(),
        ));
  }
}

class _UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return _UserCard(
            user: state.user,
          );
        }
        if (state is UserError) {
          return _buildUserError(context);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildUserError(BuildContext context) => Column(
        children: [
          Text('Ocorreu um erro ao carregar usuário.'),
          ElevatedButton(
            onPressed: () {
              context.read<UserCubit>().reloadUser();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      );
}

class _UserCard extends StatelessWidget {
  final User user;

  const _UserCard({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                foregroundImage: NetworkImage('${user.avatarUrl}'),
                radius: 90,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '${user.login}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '${user.bio}',
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItem(context, '${user.followers}', 'followers'),
                  _buildItem(context, '${user.following}', ' following'),
                  _buildItem(context, '${user.publicRepos}', ' repos'),
                ],
              ),
            ),
            _ReposList(),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, String subtitle) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _ReposList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepoCubit, RepoState>(builder: (context, state) {
      if (state is RepoError) {
        return _buildRepoError(context);
      }
      if (state is RepoLoaded) {
        return _buildRepos(state.repos);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget _buildRepoError(BuildContext context) => Column(
        children: [
          Text('Ocorreu um erro ao carregar repositórios.'),
          ElevatedButton(
            onPressed: () {
              context.read<RepoCubit>().reloadRepos();
            },
            child: Text('Tentar novamente'),
          ),
        ],
      );

  Widget _buildRepos(List<Repo> repos) => Column(
        children: repos
            .map(
              (e) => ListTile(
                title: Text('${e.name}'),
                subtitle: Text('${e.language}'),
              ),
            )
            .toList(),
      );
}
