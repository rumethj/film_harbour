import 'package:film_harbour/api_key/api_links.dart';
import 'package:film_harbour/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieDetailsPage extends StatefulWidget {

  var itemId;

  MovieDetailsPage(this.itemId);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  List<Map<String, dynamic>> itemDetails = [];
  List<Map<String, dynamic>> similarItems = [];
  List<Map<String, dynamic>> recommendedList = [];
  List<Map<String, dynamic>> trailerList = [];
  List<Map<String, dynamic>> userReviews = [];

  List<Map<String, dynamic>> genresList = [];

  Future <void> movieDetails() async
  {
    // Movie Details
    var movieDetailsResponse = await http.get(Uri.parse(ApiLink.movieDetailsUrl(widget.itemId)));
    print('Response Status Code: ${movieDetailsResponse.statusCode}');
    if (movieDetailsResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(movieDetailsResponse.body);
      var movieDetailsJsonResults = jsonDecode(movieDetailsResponse.body)['results'];
        
      for (var i = 0; i< movieDetailsJsonResults.length; i++)
      {
        itemDetails.add({
          'backdrop_path': movieDetailsJsonResults[i]['backdrop_path'],
          'title': movieDetailsJsonResults[i]['title'],
          'poster_path': movieDetailsJsonResults[i]['poster_path'],
          'vote_average': movieDetailsJsonResults[i]['vote_average'],
          'date': movieDetailsJsonResults[i]['release_date'],
          'overview': movieDetailsJsonResults[i]['overview'],
          'runtime': movieDetailsJsonResults[i]['runtime'],
          'budget': movieDetailsJsonResults[i]['budget'],
          'revenue': movieDetailsJsonResults[i]['revenue'],

        });
      }
      for (int i = 0; i<movieDetailsJsonResults['genres'].length; i++)
      {
        genresList.add(movieDetailsJsonResults['genres'][i]['name']);
      }
    } 
    else
    {
      print("Error: ${movieDetailsResponse.statusCode}:${movieDetailsResponse.reasonPhrase}");
    }

    // Similar Movies
    var similarMoviesResponse = await http.get(Uri.parse(ApiLink.movieSimilarUrl(widget.itemId)));
    print('Response Status Code: ${similarMoviesResponse.statusCode}');
    if (similarMoviesResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(similarMoviesResponse.body);
      var similarMoviesJsonResults = jsonDecode(similarMoviesResponse.body)['results']; // replace with tempData['results'];
        
      for (var i = 0; i< similarMoviesJsonResults.length; i++)
      {
        similarItems.add({
          'backdrop_path': similarMoviesJsonResults[i]['backdrop_path'],
          'title': similarMoviesJsonResults[i]['title'],
          'poster_path': similarMoviesJsonResults[i]['poster_path'],
          'vote_average': similarMoviesJsonResults[i]['vote_average'],
          'date': similarMoviesJsonResults[i]['release_date'],
          'id': similarMoviesJsonResults[i]['id'],
        });
      }
    } 
    else
    {
      print("Error: ${similarMoviesResponse.statusCode}:${similarMoviesResponse.reasonPhrase}");
    }

    // Recommended Movies
    var recommendedMoviesResponse = await http.get(Uri.parse(ApiLink.movieRecommendationsUrl(widget.itemId)));
    print('Response Status Code: ${recommendedMoviesResponse.statusCode}');
    if (recommendedMoviesResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(recommendedMoviesResponse.body);
      var recommendedMoviesJsonResults = jsonDecode(recommendedMoviesResponse.body)['results']; // replace with tempData['results'];
        
      for (var i = 0; i< recommendedMoviesJsonResults.length; i++)
      {
        recommendedList.add({
          'backdrop_path': recommendedMoviesJsonResults[i]['backdrop_path'],
          'title': recommendedMoviesJsonResults[i]['title'],
          'poster_path': recommendedMoviesJsonResults[i]['poster_path'],
          'vote_average': recommendedMoviesJsonResults[i]['vote_average'],
          'date': recommendedMoviesJsonResults[i]['release_date'],
          'id': recommendedMoviesJsonResults[i]['id'],
        });
      }
    } 
    else
    {
      print("Error: ${recommendedMoviesResponse.statusCode}:${recommendedMoviesResponse.reasonPhrase}");
    }

    // Movie Trailers
    var movieTrailersResponse = await http.get(Uri.parse(ApiLink.movieTrailerUrl(widget.itemId)));
    print('Response Status Code: ${movieTrailersResponse.statusCode}');
    if (movieTrailersResponse.statusCode == 200)
    {
      //var tempData = jsonDecode(movieTrailersResponse.body);
      var movieTrailersJsonResults = jsonDecode(movieTrailersResponse.body)['results']; // replace with tempData['results'];
        
      for (var i = 0; i< movieTrailersJsonResults.length; i++)
      {
        if (movieTrailersJsonResults[i]['type'] == "Trailer")
        {
          trailerList.add({
            "key": movieTrailersJsonResults[i]['key'],
          });
        }
        trailerList.add({'key': 'aJ0cZTcTh90'});
      }
    } 
    else
    {
      print("Error: ${movieTrailersResponse.statusCode}:${movieTrailersResponse.reasonPhrase}");
    }

    // User Reviews
    var userReviewResponse = await http.get(Uri.parse(ApiLink.movieReviewsUrl(widget.itemId)));
    print('Response Status Code: ${userReviewResponse.statusCode}');
    if (userReviewResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(userReviewResponse.body);
      var userReviewJsonResults = jsonDecode(userReviewResponse.body)['results']; // replace with tempData['results'];
        
      for (var i = 0; i< userReviewJsonResults.length; i++)
      {
        userReviews.add({
          'name': userReviewJsonResults[i]['author'],
          'review': userReviewJsonResults[i]['content'],
          'rating': userReviewJsonResults[i]['author_details']['rating'] == null
              ? "Not Rated" : userReviewJsonResults[i]['author_details']['rating'].toString(),
          'profileImage': userReviewJsonResults[i]['author_details']['avatar_path'] == null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-client.png"
              : ApiConstants.baseImageUrl + userReviewJsonResults[i]['author_details']['avatar_path'],
          'date': userReviewJsonResults[i]['created_at'].substring(0,10),
          'full_review_url': userReviewJsonResults[i]['url'],
        });
      }
    } 
    else
    {
      print("Error: ${userReviewResponse.statusCode}:${userReviewResponse.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}