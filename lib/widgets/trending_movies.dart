import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils.dart';

import '../models/trending.dart';
import '../services/services.dart';

// ignore: must_be_immutable
class TrendingMovies extends StatefulWidget {
  const TrendingMovies({Key? key}) : super(key: key);

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  late Future<Trending> future;
  @override
  void initState() {
    future = getTrendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Trending>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.results;
          return CarouselSlider.builder(
              itemCount: data!.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        '$imageUrl${data[index].posterPath!}',
                        width: 174.5,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 60,
                          width: 175,
                          padding: const EdgeInsets.all(10),
                          color: Colors.black45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].title ?? data[index].name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                    // max genre length = 3
                                    data[index].genreIds!.length < 4
                                        ? data[index].genreIds!.length
                                        : 3,
                                    (genreIndex) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Text(
                                            getGenre(
                                                data[index]
                                                    .genreIds![genreIndex],
                                                genreIndex),
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                  enableInfiniteScroll: true,
                  reverse: true,
                  viewportFraction: .5,
                  enlargeCenterPage: true,
                  aspectRatio: 1.5));
        } else if (snapshot.hasError) {
          throw snapshot.error.toString();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
