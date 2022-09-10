import 'package:http/http.dart' as http;
import 'package:movie_app/models/trending.dart';

Future<Trending> getTrendingMovies() async {
  const url =
      'https://api.themoviedb.org/3/trending/all/day?api_key=54d2d0688cf3c93a4146970f189b7b78';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return trendingFromJson(response.body);
  } else {
    throw Exception('failed to load trending');
  }
}
