import 'package:flutter/material.dart';
import '../models/repository.dart';
import '../services/github_api_service.dart';
class RepositoryItemViewModel extends ChangeNotifier {
  List<Item> repositories = [];
  List<Item> favoriteRepositories = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchRepositories(String timeFrame) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners(); // Notify listeners that loading has started

    try {
      // Fetch repositories
      repositories = await GithubApiService().fetchRepositories(timeFrame);
    } catch (e) {
      // Handle the error
      errorMessage = 'Error fetching repositories: $e';
    } finally {
      // Mark loading as done
      isLoading = false;
      notifyListeners(); // Notify listeners only once
    }
  }
}