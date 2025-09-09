import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/config/dependencies.dart';
import 'package:to_do_app/main.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) => print(event));
  runApp(MultiProvider(providers: providersLocal, child: const MainApp()));
}
