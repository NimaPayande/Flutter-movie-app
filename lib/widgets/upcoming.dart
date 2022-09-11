import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/widgets/carousel_slider.dart';
import '../models/model.dart';

// ignore: must_be_immutable
class UpcomingMovies extends StatelessWidget {
  UpcomingMovies({required this.future, Key? key}) : super(key: key);
  Future<Model> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.results;
          return Column(
            children: [
              Text(
                'Upcoming Movies',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              MyCarouselSlider(
                itemCount: data!.length,
                itemBuilder: (context, index, realindex) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    isTvShow: false,
                                    data: snapshot.data!,
                                    index: index),
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '$imageUrl${data[index].posterPath!}',
                            width: 174.5,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
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
                            color: Colors.black26,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].title ?? data[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge,
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
              )
            ],
          );
        } else if (snapshot.hasError) {
          throw snapshot.error.toString();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
