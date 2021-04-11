import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:whatsapp_api/constants.dart';
import 'package:whatsapp_api/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// we only need to initialize hive with directory in Mobile Devices
  /// so when Platform is not web
  if (!UniversalPlatform.isWeb) {
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
  }

  /// opening a basic Settings Box to store basic Settings
  await Hive.openBox(basicSettingsBoxName);

  /// opening a quickMessages Box to store Quick Messages
  await Hive.openBox(quickMessagesBoxName);

  /// checking if basic Settings box is empty
  /// if empty -> that means user is opening the app for the very first time
  /// so we will put a boolean value in the box named "isFirstTime"
  if (Hive.box(basicSettingsBoxName).isEmpty) {
    Hive.box(basicSettingsBoxName).put("isFirstTime", true);
  } else {
    /// now this is second time user is opening the app
    /// so we are setting the boolean "isFirstTime" as false from now.
    Hive.box(basicSettingsBoxName).put("isFirstTime", false);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
