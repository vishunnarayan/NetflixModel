import 'package:netflix_model/core/strings.dart';
import 'package:netflix_model/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloadsUrl = "$kBaseUrl/trending/all/day?api_key=$apiKey";
  static const searchUrl = "$kBaseUrl/search/movie?api_key=$apiKey&query=";
  static const hotAndNewMovieUrl = '$kBaseUrl/discover/movie?api_key=$apiKey';
  static const hotAndNewTvUrl = '$kBaseUrl/discover/tv?api_key=$apiKey';
}
