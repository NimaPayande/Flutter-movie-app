import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/widgets/carousel_slider.dart';
import '../models/liked_model.dart';

class Liked extends StatelessWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return ValueListenableBuilder(
      valueListenable: Hive.box<LikedModel>('liked').listenable(),
      builder: (context, Box<LikedModel> box, _) {
        if (box.isNotEmpty) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                bottom: MediaQuery.of(context).size.height / 3,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  itemBuilder: (context, index) {
                    var liked = box.getAt(index);
                    return FadeInImage(
                        fit: BoxFit.fitWidth,
                        placeholder: NetworkImage(
                          '$imageUrl${liked!.posterPath}',
                        ),
                        image: NetworkImage(
                          '$imageUrl${liked.posterPath}',
                        ));
                  },
                ),
              ),
              Center(
                child: MyCarouselSlider(
                    onPageChanged: (index, reason) {
                      controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    itemCount: box.values.length,
                    viewportFraction: .72,
                    aspectRatio: .7,
                    itemBuilder: (context, index, realindex) {
                      var liked = box.getAt(index);
                      if (!(liked?.isLiked ?? false)) {
                        liked!.delete();
                        controller.initialPage == index;
                      }
                      return FutureBuilder<Model>(
                          future: searchData(liked!.title),
                          builder: (context, snapshot) {
                            return GestureDetector(
                              onTap: () {
                                if (snapshot.hasData) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            data: snapshot.data!,
                                            index: 0,
                                            isTvShow: snapshot.data!.results[0]
                                                    .mediaType ==
                                                MediaType.tv),
                                      ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Connection Failed'),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              },
                              child: Container(
                                width: 250,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 300,
                                        margin:
                                            const EdgeInsets.only(bottom: 25),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '$imageUrl${liked.posterPath}'))),
                                      ),
                                      Text(
                                        liked.title,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // stars
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(5, (i) {
                                            return Icon(
                                              Icons.star,
                                              color: i < (liked.voteAverage / 2)
                                                  ? Colors.amber
                                                  : Colors.grey,
                                            );
                                          })),
                                      const Spacer(),
                                      Expanded(
                                          child: Text(
                                        getGenres(liked.genres),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      )),

                                      const Spacer(
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              liked.delete();
                                              if (box.values.length > 3) {
                                                controller.jumpToPage(
                                                  index,
                                                );
                                              } else if (box.values.length ==
                                                  2) {
                                                controller.jumpToPage(
                                                  1,
                                                );
                                              } else {
                                                controller.jumpToPage(
                                                  0,
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.delete_sweep,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          );
        }
        return const Center(
          child: Text('No Item'),
        );
      },
    );
  }
}
