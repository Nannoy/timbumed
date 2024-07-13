import 'package:flutter/material.dart';
import 'package:timbumed/config/config.dart';
import 'package:timbumed/view/main.dart';
import 'package:timbumed/view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = Config();
  await config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const SplashScreen(),
      routes: {
        '/main': (context) => const MainView(),
      },
    );
  }
}