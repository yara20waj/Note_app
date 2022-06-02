import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NewNote_Screen.dart';
import 'database/db_controller.dart';
import 'database/dbhelper.dart';
import 'Empty_home.dart';
import 'Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBProvider().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AccountChangeNotifier>(
              create: (_) => AccountChangeNotifier()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const launch_Screen(),
          routes: {
            '/home': (context) => home_Screen(),
            '/newNote': (context) => addNote_Screen(),
          },
        ));
  }
}
