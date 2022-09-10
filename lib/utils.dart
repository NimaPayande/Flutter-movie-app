const imageUrl = 'https://image.tmdb.org/t/p/w500';

Map<String, int> genres = {
  'Action': 28,
  'Adventure': 12,
  'Animation': 16,
  'Comedy': 35,
  'Crime': 80,
  'Documentary': 99,
  'Drama': 18,
  'Family': 10751,
  'Fantasy': 14,
  'History': 36,
  'Horror': 27,
  'Music': 10402,
  'Mystery': 9648,
  'Romance': 10749,
  'Science Fiction': 878,
  'TV Movie': 10770,
  'Thriller ': 53,
  'War': 10752,
  'Western': 37,
  ' Action & Adventure': 10759,
  'Kids': 10762,
  'News': 10763,
  'Reality': 10764,
  'Sci-Fi & Fantasy ': 10765,
  'Soap    ': 10766,
  'Talk     ': 10767,
  'War & Politics   ': 10768,
  'Western  ': 37,
};

getGenre(int genreId, int index) {
  late final String genre;

  genre = genres.keys
      .where((element) => genres.containsValue(genreId))
      .elementAt(index);
  return genre;
}
