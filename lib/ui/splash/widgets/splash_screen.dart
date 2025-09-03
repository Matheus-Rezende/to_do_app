import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redirect();
    });
    super.initState();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      context.go(Routes.todos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/images/todo.png', height: 200.0, width: 200.0)));
  }
}
