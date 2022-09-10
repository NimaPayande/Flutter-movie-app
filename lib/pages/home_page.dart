import 'package:flutter/material.dart';
import 'package:movie_app/models/trending.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/widgets/trending_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: TrendingMovies());
  }
}
