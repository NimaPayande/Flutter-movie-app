import 'package:flutter/material.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/widgets/movies_listview.dart';
import 'package:movie_app/widgets/search.dart';
import '../models/movie_model.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<Model> comedyFuture,
      actionFuture,
      horrorFuture,
      dramaFuture,
      romanceFuture,
      familyFuture;
  @override
  void initState() {
    comedyFuture = discoverMovies(genreId: 35);
    actionFuture = discoverMovies(genreId: 28);
    horrorFuture = discoverMovies(genreId: 27);
    dramaFuture = discoverMovies(genreId: 18);
    familyFuture = discoverMovies(genreId: 10751);
    romanceFuture = discoverMovies(genreId: 10749);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: Search());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 70,
            child: Card(
              color: Colors.grey.withOpacity(.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Movie Search...'),
                  ],
                ),
              ),
            ),
          ),
        ),
        MoviesListView(future: comedyFuture, headlineText: 'Comedy Movies'),
        MoviesListView(future: actionFuture, headlineText: 'Action Movies'),
        MoviesListView(future: dramaFuture, headlineText: 'Drama Movies'),
        MoviesListView(future: horrorFuture, headlineText: 'Horror Movies'),
        MoviesListView(future: familyFuture, headlineText: 'Family Movies'),
        MoviesListView(future: romanceFuture, headlineText: 'Romance Movies'),
      ],
    );
  }
}
