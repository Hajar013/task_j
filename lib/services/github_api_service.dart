import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repository.dart';

class GithubApiService {
  Future<List<Item>> fetchRepositories(String timeFrame) async {
    final String query = _timeForQuery(timeFrame);
    final url = Uri.parse(
        'https://api.github.com/search/repositories?q=$query&sort=stars&order=desc');
    // Make the HTTP GET request
    final response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Check the response status
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Item> repos =
      (data['items'] as List).map((item) => Item.fromJson(item)).toList();
      return repos;
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  String _timeForQuery(String timeFrame) {
    final now = DateTime.now();
    String formattedDate;

    if (timeFrame == 'day') {
      formattedDate =
      now.subtract(Duration(days: 1)).toIso8601String().split('T')[0];
    } else if (timeFrame == 'week') {
      formattedDate =
      now.subtract(Duration(days: 7)).toIso8601String().split('T')[0];
    } else {
      formattedDate =
      now.subtract(Duration(days: 30)).toIso8601String().split('T')[0];
    }

    return 'created:>$formattedDate';
  }
}