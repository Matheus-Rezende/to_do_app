import 'package:flutter/material.dart';
import 'package:to_do_app/routing/router.dart';
import 'main_staging.dart' as staging;
import 'main_development.dart' as develop;

void main() => develop.main();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(darkTheme: ThemeData.dark(), routerConfig: routerConfig());
  }
}
