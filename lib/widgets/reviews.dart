import 'package:flutter/material.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/services/services.dart';
import '../utils.dart';

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({Key? key, required this.isTvShow, required this.id})
      : super(key: key);
  final int id;
  final bool isTvShow;
  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  late Future<Review> _future;
  @override
  void initState() {
    _future = getReviews(widget.id, widget.isTvShow);
    super.initState();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Review>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var data = snapshot.data?.results;
          return AspectRatio(
            aspectRatio: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.all(5),
                    child: Card(
                      color: Colors.black38,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 40,
                          child: ClipOval(
                            child: FadeInImage(
                              width: 60,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '$imageUrl${data[index].authorDetails.avatarPath}'),
                              placeholder: const NetworkImage(
                                  'http://www.familylore.org/images/2/25/UnknownPerson.png'),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                    'http://www.familylore.org/images/2/25/UnknownPerson.png');
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          data[index].author,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: isExpanded
                                  ? const BoxConstraints()
                                  : const BoxConstraints(maxHeight: 120),
                              child: Text(
                                data[index].content,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            isExpanded
                                ? const SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isExpanded = true;
                                          });
                                        },
                                        child: const Text('Read More...')),
                                  ),
                            Text(
                              data[index].createdAt.toString().substring(0, 10),
                              style: const TextStyle(color: Colors.white54),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
