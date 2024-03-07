import 'package:flutter/material.dart';
import 'package:webtoon_app/Home_Screen/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home_screen(),
    );
  }
}
