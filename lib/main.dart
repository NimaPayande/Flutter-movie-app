import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/main_page.dart';
import 'package:movie_app/models/liked_model.dart';
import 'package:movie_app/utils.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LikedModel>(LikedModelAdapter());
  await Hive.openBox<LikedModel>('liked');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie app',
      theme: ThemeData(
          brightness: Brightness.dark,
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
          scaffoldBackgroundColor: kBackgoundColor,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder()
          })),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
