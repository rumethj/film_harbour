import 'package:film_harbour/api_key/api_constants.dart';

class ApiLink
{
  ApiLink._();

  static const String trendingMovieDayUrl = "${ApiConstants.baseUrl}trending/movie/day?api_key=${ApiConstants.apiKey}";
  static const String trendingTvDayUrl = "${ApiConstants.baseUrl}trending/tv/day?api_key=${ApiConstants.apiKey}";


  static String popularUrl(String type) =>  "${ApiConstants.baseUrl}$type/popular?api_key=${ApiConstants.apiKey}";
  static String topRatedUrl(String type) =>  "${ApiConstants.baseUrl}$type/top_rated?api_key=${ApiConstants.apiKey}";

  static const String upcomingMovieUrl = "${ApiConstants.baseUrl}movie/upcoming?api_key=${ApiConstants.apiKey}";
  static const String upcomingTvShowUrl =  "${ApiConstants.baseUrl}discover/tv?api_key=${ApiConstants.apiKey}&sort_by=first_air_date.asc&first_air_date.gte=2023-03-01&first_air_date.lte=2023-04-1";

  static const String showingOnCinemaUrl =  "${ApiConstants.baseUrl}movie/now_playing?api_key=${ApiConstants.apiKey}&sort_by=popularity.desc";
  static const String showingOnTVUrl =  "${ApiConstants.baseUrl}tv/on_the_air?api_key=${ApiConstants.apiKey}&sort_by=popularity.desc";
  
  static String topGrossingUrl(String type) =>  "${ApiConstants.baseUrl}discover/$type?api_key=${ApiConstants.apiKey}&sort_by=revenue.desc";
  static String forKidsUrl(String type) => "${ApiConstants.baseUrl}discover/$type?api_key=${ApiConstants.apiKey}&with_genres=16&include_adult=false";
  
  static const String bestMoviesUrl = "${ApiConstants.baseUrl}discover/movie?api_key=${ApiConstants.apiKey}&sort_by=vote_average.desc&vote_count.gte=500&primary_release_year=2024";
  static const String bestTvShowsUrl = "${ApiConstants.baseUrl}discover/tv?api_key=${ApiConstants.apiKey}&sort_by=vote_average.desc&vote_count.gte=100&first_air_date_year=2024";

  static String discoverUrl(String type, String sortSelection) => "${ApiConstants.baseUrl}discover/$type?api_key=${ApiConstants.apiKey}&sort_by=$sortSelection";

  // Specific Detail Urls
  static String itemDetailsUrl(String id, String type) => '${ApiConstants.baseUrl}$type/$id?api_key=${ApiConstants.apiKey}';
  static String itemReviewsUrl(String id, String type) => '${ApiConstants.baseUrl}$type/$id/reviews?api_key=${ApiConstants.apiKey}';
  static String itemSimilarUrl(String id, String type) => '${ApiConstants.baseUrl}$type/$id/similar?api_key=${ApiConstants.apiKey}';
  static String itemRecommendationsUrl(String id, String type) => '${ApiConstants.baseUrl}$type/$id/recommendations?api_key=${ApiConstants.apiKey}';
  static String itemTrailerUrl(String id, String type) => '${ApiConstants.baseUrl}$type/$id/videos?api_key=${ApiConstants.apiKey}';

  // Search
  static String searchUrl(String query) => '${ApiConstants.baseUrl}search/multi?api_key=${ApiConstants.apiKey}&query=$query&sort_by=popularity.desc';
 }