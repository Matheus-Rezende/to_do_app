import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/config/dependencies.dart';
import 'package:to_do_app/main.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((log) => print('[${log.level}] - [${log.loggerName}] - [${log.message}]'));
  runApp(MultiProvider(providers: providersLocal, child: const MainApp()));
}
