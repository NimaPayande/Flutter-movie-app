import 'package:flutter/material.dart';
import 'package:movie_app/main_page.dart';
import 'package:movie_app/utils.dart';

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
          fontFamily: 'poppins',
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.white,
              ),
              bodyLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              titleLarge: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          scaffoldBackgroundColor: kBackgoundColor),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
