import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/viewmodels/homepage_controller.dart';
import 'package:quotes_api_app/views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<QuotesData>(
          create: (_) => QuotesData(), child: HomePage()),
    );
  }
}
