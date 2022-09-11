import 'package:flutter/material.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/utils.dart';
import '../models/model.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late Future<Model> _future;
  int genreId = 28;
  @override
  void initState() {
    //_future = discoverMovies();
    super.initState();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
        future: _future,
        builder: (context, snapshot) {
          var data = snapshot.data?.results;

          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                AspectRatio(
                  aspectRatio: 1.6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                          '$imageUrl${data[index].posterPath}');
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
