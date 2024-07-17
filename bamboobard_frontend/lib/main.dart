import 'package:bamboobard_frontend/screens/server_entry.screen.dart';
import 'package:bamboobard_frontend/screens/splash.screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/server-selection': (context) => ServerSelectionScreen(),
      },
    );
  }
}
