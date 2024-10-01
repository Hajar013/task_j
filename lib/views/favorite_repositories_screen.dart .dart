import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repository.dart';
import '../services/favorite_repositories_service.dart';
import '../viewmodels/RepositoryItemViewModel.dart';
import 'repository_detail_screen.dart';

// class FavoriteRepositoriesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<RepositoryItemViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Repositories'),
//       ),
//       body: ListView.builder(
//         itemCount: viewModel.favoriteRepositories.length,
//         itemBuilder: (context, index) {
//           final repository = viewModel.favoriteRepositories[index];
//           return ListTile(
//             title: Text(repository.name),
//             subtitle: Text(repository.owner.login),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       RepositoryDetailScreen(repository: repository),
//                 ),
//               );
//             },
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(repository.owner.avatarUrl),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class FavoriteRepositoriesScreen extends StatefulWidget {
//   @override
//   State<FavoriteRepositoriesScreen> createState() =>
//       _FavoriteRepositoriesScreenState();
// }

// class _FavoriteRepositoriesScreenState
//     extends State<FavoriteRepositoriesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // void _removeFromFavorites(Item repoName) async {
//     //   await FavoriteService().removeFavorite(repoName);
//     //   setState(() {
//     //     // After removal, update the state to refresh the UI
//     //     getFavoriteRepositories();
//     //   });
//     // }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Repositories'),
//       ),
//       body: FutureBuilder<List<Item>>(
//         future: _repositories,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No repositories available.'));
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final repo = snapshot.data![index]; // Get `Item` object
//               return ListTile(
//                 title: Text(repo.name),
//                 trailing: IconButton(
//                   icon: Icon(
//                     repo.isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: repo.isFavorite ? Colors.red : null,
//                   ),
//                   onPressed: () async {
//                     // Toggle favorite status
//                     await _favoriteService.toggleFavorite(repo.name);
//                     setState(() {}); // Refresh UI after toggling
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<List<Item>> getFavoriteRepositories() =>
//       FavoriteService().getFavoriteRepositories();
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/repository.dart';
import '../services/favorite_repositories_service.dart';
import '../viewmodels/RepositoryItemViewModel.dart';
import 'repository_detail_screen.dart';

// class FavoriteRepositoriesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<RepositoryItemViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Repositories'),
//       ),
//       body: ListView.builder(
//         itemCount: viewModel.favoriteRepositories.length,
//         itemBuilder: (context, index) {
//           final repository = viewModel.favoriteRepositories[index];
//           return ListTile(
//             title: Text(repository.name),
//             subtitle: Text(repository.owner.login),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       RepositoryDetailScreen(repository: repository),
//                 ),
//               );
//             },
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(repository.owner.avatarUrl),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class FavoriteRepositoriesScreen extends StatefulWidget {
//   @override
//   State<FavoriteRepositoriesScreen> createState() =>
//       _FavoriteRepositoriesScreenState();
// }

// class _FavoriteRepositoriesScreenState
//     extends State<FavoriteRepositoriesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // void _removeFromFavorites(Item repoName) async {
//     //   await FavoriteService().removeFavorite(repoName);
//     //   setState(() {
//     //     // After removal, update the state to refresh the UI
//     //     getFavoriteRepositories();
//     //   });
//     // }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Repositories'),
//       ),
//       body: FutureBuilder<List<Item>>(
//         future: _repositories,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No repositories available.'));
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final repo = snapshot.data![index]; // Get Item object
//               return ListTile(
//                 title: Text(repo.name),
//                 trailing: IconButton(
//                   icon: Icon(
//                     repo.isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: repo.isFavorite ? Colors.red : null,
//                   ),
//                   onPressed: () async {
//                     // Toggle favorite status
//                     await _favoriteService.toggleFavorite(repo.name);
//                     setState(() {}); // Refresh UI after toggling
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<List<Item>> getFavoriteRepositories() =>
//       FavoriteService().getFavoriteRepositories();
// }
import 'package:flutter/material.dart';
import '../services/favorite_repositories_service.dart';

class FavoriteRepositoriesScreen extends StatefulWidget {

  @override
  State<FavoriteRepositoriesScreen> createState() =>
      _FavoriteRepositoriesScreenState();
}

class _FavoriteRepositoriesScreenState
    extends State<FavoriteRepositoriesScreen> {
  late Future<List<Item>> favoriteReposFuture;

  @override
  void initState() {
    super.initState();
    favoriteReposFuture = getFavoriteRepositories();

  }

  @override
  Widget build(BuildContext context) {
    void _removeFromFavorites(int repoId) async {
      await FavoriteService().removeFavorite(repoId);
      setState(() {
        // Refresh the favorite repositories list after removing
        favoriteReposFuture = getFavoriteRepositories();
      });
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Repositories'),
      ),
      body: FutureBuilder<List<Item>>(
        future: favoriteReposFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite repositories.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final repo = snapshot.data![index]; // Get Item object
              return ListTile(
                title: Text(repo.name),
                subtitle: Text(repo.owner.login), // Display owner's login
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(repo.owner.avatarUrl),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _removeFromFavorites(repo.id); // Remove favorite by ID
                  },
                ),

              );
            },
          );
        },
      ),
    );
  }


  Future<List<Item>> getFavoriteRepositories() async {
    return await FavoriteService().getFavorites(); // Fetch favorites
  }
}
