import 'package:flutter/material.dart';
import '../models/repository.dart';
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
