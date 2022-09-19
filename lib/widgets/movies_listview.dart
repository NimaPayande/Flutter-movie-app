import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/utils.dart';
import '../models/movie_model.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({
    required this.future,
    Key? key,
    required this.headlineText,
  }) : super(key: key);
  final String headlineText;
  final Future<Model> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.results;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headlineText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          isTvShow:
                                              headlineText.contains('Movies') ||
                                                      data[index].mediaType ==
                                                          MediaType.movie
                                                  ? false
                                                  : true,
                                          data: snapshot.data!,
                                          index: index),
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  '$imageUrl${data[index].posterPath}',
                                  height: 240,
                                  width: 170,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 240,
                                      width: 170,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 170,
                              height: 50,
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].title ?? data[index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  Text(
                                    data[index].genreIds!.isNotEmpty
                                        ? getGenres(data[index].genreIds!)
                                        : '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
