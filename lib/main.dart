import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinote/db/model/note.dart';
import 'package:vinote/ui/values/colors.dart';
import 'package:vinote/ui/screens/splash_screen.dart';

import 'consts.dart';
import 'db/db.dart';

late DB db;
late SharedPreferences preferences;
String? nickname;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  db = DB(await Hive.openBox(boxName));

  preferences = await SharedPreferences.getInstance();
  nickname = preferences.getString(nicknameKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        fontFamily: "VarelaRound",
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: textColor,
          displayColor: textColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}