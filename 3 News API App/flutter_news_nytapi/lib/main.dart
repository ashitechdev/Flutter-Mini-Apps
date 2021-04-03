import 'package:flutter/material.dart';
import 'package:flutter_news_nytapi/viewmodels/top_stories.dart';
import 'package:provider/provider.dart';

import 'views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopStories>(create: (_) => TopStories()),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
