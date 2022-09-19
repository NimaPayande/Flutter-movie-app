import 'package:hive/hive.dart';
part 'liked_model.g.dart';

@HiveType(typeId: 0)
class LikedModel extends HiveObject {
  @HiveField(0)
  bool isLiked = false;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<int> genres;
  @HiveField(3)
  double voteAverage;
  @HiveField(4)
  String posterPath;

  LikedModel(
      {this.isLiked = false,
      required this.title,
      required this.genres,
      required this.voteAverage,
      required this.posterPath});
}
