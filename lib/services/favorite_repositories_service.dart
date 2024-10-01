import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/repository.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_repositories';

  Future<void> addFavorite(Item item) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    // Check if the item is already favorited
    if (!favorites.any((favorite) => favorite.id == item.id)) {
      // Set isFavorite to true before adding the item
      item.isFavorite = true; // Update the isFavorite property

      favorites.add(item); // Add the item to the favorites list
      await _saveFavorites(favorites); // Save the updated favorites list
    }

  }

  Future<void> removeFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    // Find the item by id and set its isFavorite attribute to false
    final itemToRemove = favorites.firstWhere((favorite) => favorite.id == id);

    if (itemToRemove != null) {
      // If the item exists in favorites, set its isFavorite to false
      itemToRemove.isFavorite = false;
    }

    // Remove the item from favorites
    favorites.removeWhere((favorite) => favorite.id == id);

    // Save the updated favorites list
    await _saveFavorites(favorites);


    await _saveFavorites(favorites);
  }

  Future<List<Item>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString(_favoritesKey);

    if (favoritesJson == null) {
      return [];
    }

    // Parse the JSON string into a list of Item objects
    final List<dynamic> decodedJson = json.decode(favoritesJson);
    return List<Item>.from(decodedJson.map((x) => Item.fromJson(x)));
  }

  Future<void> _saveFavorites(List<Item> favorites) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert the list of Item objects to JSON
    final favoritesJson = json.encode(favorites.map((item) => item.toJson()).toList());
    await prefs.setString(_favoritesKey, favoritesJson);
  }
}
