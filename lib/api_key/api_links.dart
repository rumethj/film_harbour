import 'package:film_harbour/api_key/api_constants.dart';

class ApiLink
{
  ApiLink._();

  static const String trendingMovieDayUrl = "${ApiConstants.baseUrl}trending/movie/day?api_key=${ApiConstants.apiKey}";
  static const String trendingTvDayUrl = "${ApiConstants.baseUrl}trending/tv/day?api_key=${ApiConstants.apiKey}";

  static const String movieTopRatedUrl = "${ApiConstants.baseUrl}movie/top_rated?api_key=${ApiConstants.apiKey}";
  static const String moviePopularUrl = "${ApiConstants.baseUrl}movie/popular?api_key=${ApiConstants.apiKey}";
  static const String movieUpcomingUrl = "${ApiConstants.baseUrl}movie/upcoming?api_key=${ApiConstants.apiKey}";
  static const String movieTopGrossingUrl = "${ApiConstants.baseUrl}discover/movie?api_key=${ApiConstants.apiKey}&sort_by=revenue.desc";

  static const String tvTopRatedUrl = "${ApiConstants.baseUrl}tv/top_rated?api_key=${ApiConstants.apiKey}";
  static const String tvPopularUrl = "${ApiConstants.baseUrl}tv/popular?api_key=${ApiConstants.apiKey}";
  static const String tvUpcomingUrl = "${ApiConstants.baseUrl}tv/upcoming?api_key=${ApiConstants.apiKey}";
  static const String tvTopGrossingUrl = "${ApiConstants.baseUrl}discover/tv?api_key=${ApiConstants.apiKey}&sort_by=revenue.desc";

  static const String testUrl = "https://api.themoviedb.org/3/trending/movies/day?api_key=${ApiConstants.apiKey}";
}