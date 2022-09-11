import 'package:flutter/material.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/widgets/cast.dart';
import 'package:movie_app/widgets/reviews.dart';
import 'package:movie_app/widgets/similar.dart';
import '../models/model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
      {Key? key,
      required this.data,
      required this.index,
      this.creditData,
      required this.isTvShow})
      : super(key: key);
  final int index;
  final Model data;
  final Credit? creditData;
  final bool isTvShow;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: MediaQuery.of(context).size.height / 2.1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '$imageUrl${data.results[index].posterPath}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((ctx, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.results[index].title ?? data.results[index].name!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Wrap(
                  children: List.generate(
                      data.results[index].genreIds!.length,
                      (genreIndex) => Padding(
                            padding: const EdgeInsets.only(right: 10, top: 4),
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              side: const BorderSide(width: 0),
                              backgroundColor: kBackgoundColor.withOpacity(.9),
                              label: Text(
                                getGenre(
                                    data.results[index].genreIds![genreIndex],
                                    genreIndex),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white70),
                              ),
                            ),
                          )),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.date_range),
                      Text(data.results[index].releaseDate == null
                          ? data.results[index].firstAirDate
                              .toString()
                              .substring(0, 4)
                          : data.results[index].releaseDate
                              .toString()
                              .substring(0, 4)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.star),
                      Text(data.results[index].voteAverage.toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Story Line',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  data.results[index].overview!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white.withOpacity(.9), fontSize: 15),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    print(data.results[index].id);
                  },
                  child: CastWidget(
                    id: data.results[index].id!,
                    isTvShow: isTvShow,
                  ),
                ),
                SimilarWidget(data: data, index: index, isTvShow: isTvShow),
                ReviewsWidget(isTvShow: isTvShow, id: data.results[index].id!)
              ],
            ),
          );
        }, childCount: 1))
      ],
    ));
  }
}
