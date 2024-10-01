import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../viewmodels/RepositoryItemViewModel.dart';
import 'package:provider/provider.dart';

class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  String _selectedTimeFrame = 'day';
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  void fetchRepositories() {
    Provider.of<RepositoryItemViewModel>(context, listen: false)
        .fetchRepositories(_selectedTimeFrame);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Repositories'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedTimeFrame,
            items: [
              DropdownMenuItem(value: 'day', child: Text('Last Day')),
              DropdownMenuItem(value: 'week', child: Text('Last Week')),
              DropdownMenuItem(value: 'month', child: Text('Last Month')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedTimeFrame = value!;
                fetchRepositories();
              });
            },
          ),
          Expanded(
            child: Consumer<RepositoryItemViewModel>(
              builder: (context, repositoryViewModel, child) {
                if (repositoryViewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: repositoryViewModel.repositories.length,
                  itemBuilder: (context, index) {
                    final repository = repositoryViewModel.repositories[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: repository.owner.avatarUrl.isNotEmpty
                            ? NetworkImage(repository.owner.avatarUrl)
                            : AssetImage(noAvatarUrl) as ImageProvider,
                      ),
                      title: Text(
                          '${repository.owner.login} / ${repository.name}'),
                      subtitle: Text(repository.description ?? "none"),
                      trailing: Text('${repository.stargazersCount} ★'),
                      onTap: () {},
                    ); // This line was missing a closing parenthesis.
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
