import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:whatsapp_api/constants.dart';
import 'package:whatsapp_api/data_models/whatsapp_message_model.dart';
import 'package:whatsapp_api/views/homepage.dart';

void main() async {
  // This can be used if you want to use hiveOffline DB in this App.
  WidgetsFlutterBinding.ensureInitialized();

  /// this initialization only needs to be done on Mobiles only
  if (!UniversalPlatform.isWeb) {
    final document = await getApplicationDocumentsDirectory();
    Hive..init(document.path);
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

  ///registering WhatsApp Messages Model's Adapter
  Hive..registerAdapter(WhatsAppMessageModelAdapter());

  /// opening a history Box to store History of sent Messages of type WhatsAppMessageModel
  await Hive.openBox<WhatsAppMessageModel>(historyBoxName);

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
