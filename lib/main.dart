import 'package:flutter/material.dart';
import 'package:to_do_app/routing/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(darkTheme: ThemeData.dark(), routerConfig: routerConfig());
  }
}
