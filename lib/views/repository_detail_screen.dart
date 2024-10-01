import 'package:flutter/material.dart';
import '../models/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final Item repository;

  const RepositoryDetailScreen({Key? key, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Owner: ${repository.owner.login}'),
            Text(
                'Language: ${repository.language ?? 'N/A'}'), // Show 'N/A' if language is null
            Text('Stars: ${repository.stargazersCount}'),
            Text('Forks: ${repository.forks}'),
            Text(
                'Created At: ${repository.createdAt.toLocal()}'),
            SizedBox(height: 16), // Add some spacing
            TextButton(
              onPressed: () async {
                final url = repository.htmlUrl;
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri); // Launch URL in the default browser
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text('View on GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
