import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/RepositoryItemViewModel.dart';
import 'views/repository_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RepositoryItemViewModel(),
      child: MaterialApp(
        title: 'GitHub Trending Repositories',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: RepositoryListScreen(),
      ),
    );
  }
}
