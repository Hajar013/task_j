import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/favorite_repositories_service.dart';
import '../utils/constants.dart';
import '../viewmodels/RepositoryItemViewModel.dart';
import '../models/repository.dart';
import 'favorite_repositories_screen.dart .dart';
import 'repository_detail_screen.dart';

class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  String _selectedTimeFrame = 'day';
  List<Item> favoriteRepos = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
    fetchRepositories();
  }

  void _fetchFavorites() async {
    // Fetch the list of favorite repositories as Item objects
    favoriteRepos = await FavoriteService().getFavorites();
    setState(() {}); // Refresh the UI
  }

  void fetchRepositories() {
    // Fetch the repositories based on the selected time frame
    Provider.of<RepositoryItemViewModel>(context, listen: false)
        .fetchRepositories(_selectedTimeFrame);
  }

  void _toggleFavorite(Item repository) async {
    // Toggle the favorite status of the repository
    if (repository.isFavorite) {
      // If it is currently a favorite, remove it from favorites
      await FavoriteService().removeFavorite(repository.id);
    } else {
      // If it is not a favorite, add it to favorites
      await FavoriteService().addFavorite(repository);
    }


    // Refresh the UI
    setState(() {});
  }


  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Trending Repositories'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => FavoriteRepositoriesScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Dropdown for timeframes
//           DropdownButton<String>(
//             value: _selectedTimeFrame,
//             items: [
//               DropdownMenuItem(value: 'day', child: Text('Last Day')),
//               DropdownMenuItem(value: 'week', child: Text('Last Week')),
//               DropdownMenuItem(value: 'month', child: Text('Last Month')),
//             ],
//             onChanged: (value) {
//               setState(() {
//                 _selectedTimeFrame = value!;
//                 fetchRepositories();
//               });
//             },
//           ),
//           Expanded(
//             child: Consumer<RepositoryItemViewModel>(
//               builder: (context, repositoryViewModel, child) {
//                 if (repositoryViewModel.isLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return ListView.builder(
//                   itemCount: repositoryViewModel.repositories.length,
//                   itemBuilder: (context, index) {
//                     final repository = repositoryViewModel.repositories[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: repository.owner.avatarUrl.isNotEmpty
//                         ? NetworkImage(repository.owner.avatarUrl)
//                             as ImageProvider
//                             : AssetImage(noAvatarUrl),
//                       ),
//                       title: Text(
//                           '${repository.owner.login} / ${repository.name}'),
//                       subtitle: Text(
//                           repository.description ?? "No description available"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('${repository.stargazersCount} ★'),
//                           IconButton(
//                               icon: Icon(
//                                 repository.isFavorite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color:
//                                 repository.isFavorite ? Colors.red : null,
//                               ),
//                               onPressed: () => _toggleFavorite(repository)),
//                         ],
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 RepositoryDetailScreen(repository: repository),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Repositories'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoriteRepositoriesScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Dropdown for timeframes
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

                // Check if the repositories list is empty
                if (repositoryViewModel.repositories.isEmpty) {
                  return Center(child: Text("No repositories found."));
                }

                return ListView.builder(
                  itemCount: repositoryViewModel.repositories.length,
                  itemBuilder: (context, index) {
                    final repository = repositoryViewModel.repositories[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: repository.owner.avatarUrl.isNotEmpty
                            ? NetworkImage(repository.owner.avatarUrl)
                            : AssetImage(noAvatarUrl),
                      ),
                      title: Text('${repository.owner.login} / ${repository
                          .name}'),
                      subtitle: Text(
                          repository.description ?? "No description available"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${repository.stargazersCount} ★'),
                          IconButton(
                            icon: Icon(
                              repository.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: repository.isFavorite ? Colors.red : null,
                            ),
                            onPressed: () => _toggleFavorite(repository),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RepositoryDetailScreen(repository: repository),
                          ),
                        );
                      },
                    );
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

