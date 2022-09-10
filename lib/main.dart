import 'package:flutter/material.dart';
import 'package:movie_app/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie app',
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: const Color(0xFF161624)),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
