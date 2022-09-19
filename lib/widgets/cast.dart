import 'package:flutter/material.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/utils.dart';

class CastWidget extends StatefulWidget {
  const CastWidget({Key? key, required this.id, required this.isTvShow})
      : super(key: key);
  final int id;
  final bool isTvShow;

  @override
  State<CastWidget> createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {
  late Future<Credit> creditsFuture;
  @override
  void initState() {
    creditsFuture = getCredits(widget.id, widget.isTvShow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Credit>(
      future: creditsFuture,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var data = snapshot.data?.cast;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Cast',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              AspectRatio(
                aspectRatio: 2.1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      data!.length > 20 ? 20 : data.length, //max length = 20
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40,
                            child: ClipOval(
                              child: FadeInImage(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '$imageUrl${data[index].profilePath}'),
                                placeholder: const NetworkImage(
                                    'http://www.familylore.org/images/2/25/UnknownPerson.png'),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.network(
                                      'http://www.familylore.org/images/2/25/UnknownPerson.png');
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              data[index].name!,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          throw snapshot.error.toString();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
