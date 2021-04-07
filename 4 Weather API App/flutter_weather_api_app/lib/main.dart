import 'package:flutter/material.dart';
import 'package:flutter_weather_api_app/controllers/homepage_controller.dart';
import 'package:flutter_weather_api_app/views/homepage/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomePageController())
        ],
        child: MaterialApp(
          home: HomePage(),
        ));
  }
}
