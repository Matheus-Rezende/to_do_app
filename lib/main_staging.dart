import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/config/dependencies.dart';
import 'package:to_do_app/main.dart';

void main() {
  runApp(MultiProvider(providers: providersRemote, child: const MainApp()));
}
