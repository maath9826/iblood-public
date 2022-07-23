import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/SplashPage';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
