import 'package:film_harbour/api_key/api_links.dart';
import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/repeated_widgets/bottom_nav_bar.dart';
import 'package:film_harbour/repeated_widgets/item_slider.dart';
import 'package:film_harbour/repeated_widgets/user_list_action.dart';
import 'package:film_harbour/repeated_widgets/user_review_element.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:film_harbour/repeated_widgets/trailer_element.dart';
import 'package:share_plus/share_plus.dart';


class MovieDetailsPage extends StatefulWidget {

  var itemId;

  MovieDetailsPage(this.itemId);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  List<Map<String, dynamic>> itemDetails = [];
  List<Map<String, dynamic>> similarItems = [];
  List<Map<String, dynamic>> recommendedItems = [];
  List<Map<String, dynamic>> trailerList = [];
  List<Map<String, dynamic>> userReviews = [];

  List genresList = [];

  Future <void> movieDetails() async
  {
    // Movie Details
    var movieDetailsResponse = await http.get(Uri.parse(ApiLink.itemDetailsUrl(widget.itemId.toString(), 'movie')));
    print('Response Status Code: ${movieDetailsResponse.statusCode}');
    if (movieDetailsResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(movieDetailsResponse.body);
      var movieDetailsJsonResults = jsonDecode(movieDetailsResponse.body);
        
      // for (var i = 0; i< 1; i++)
      // {
        itemDetails.add({
          'backdrop_path': movieDetailsJsonResults['backdrop_path'],
          'title': movieDetailsJsonResults['title'],
          'poster_path': movieDetailsJsonResults['poster_path'],
          'vote_average': movieDetailsJsonResults['vote_average'],
          'release_date': movieDetailsJsonResults['release_date'],
          'overview': movieDetailsJsonResults['overview'],
          'runtime': movieDetailsJsonResults['runtime'],
          'budget': movieDetailsJsonResults['budget'] > 0
          ? movieDetailsJsonResults['budget']
          : "N/A",
          'revenue': movieDetailsJsonResults['revenue'] > 0
          ? movieDetailsJsonResults['revenue']
          : "N/A",
          'media_type': 'movie',
        });
      //}
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
    var similarMoviesResponse = await http.get(Uri.parse(ApiLink.itemSimilarUrl(widget.itemId.toString(), 'movie')));
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
          'release_date': similarMoviesJsonResults[i]['release_date'],
          'id': similarMoviesJsonResults[i]['id'],
        });
      }
    } 
    else
    {
      print("Error: ${similarMoviesResponse.statusCode}:${similarMoviesResponse.reasonPhrase}");
    }

    // Recommended Movies
    var recommendedMoviesResponse = await http.get(Uri.parse(ApiLink.itemRecommendationsUrl(widget.itemId.toString(), 'movie')));
    print('Response Status Code: ${recommendedMoviesResponse.statusCode}');
    if (recommendedMoviesResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(recommendedMoviesResponse.body);
      var recommendedMoviesJsonResults = jsonDecode(recommendedMoviesResponse.body)['results']; // replace with tempData['results'];
        
      for (var i = 0; i< recommendedMoviesJsonResults.length; i++)
      {
        recommendedItems.add({
          'backdrop_path': recommendedMoviesJsonResults[i]['backdrop_path'],
          'title': recommendedMoviesJsonResults[i]['title'],
          'poster_path': recommendedMoviesJsonResults[i]['poster_path'],
          'vote_average': recommendedMoviesJsonResults[i]['vote_average'],
          'release_date': recommendedMoviesJsonResults[i]['release_date'],
          'id': recommendedMoviesJsonResults[i]['id'],
        });
      }
    } 
    else
    {
      print("Error: ${recommendedMoviesResponse.statusCode}:${recommendedMoviesResponse.reasonPhrase}");
    }


    // User Reviews
    var userReviewResponse = await http.get(Uri.parse(ApiLink.itemReviewsUrl(widget.itemId.toString(),'movie')));
    print('Response Status Code: ${userReviewResponse.statusCode}');
    if (userReviewResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(userReviewResponse.body);
      var userReviewJsonResults = jsonDecode(userReviewResponse.body)['results']; // replace with tempData['results'];
      for (var i = 0; i< userReviewJsonResults.length; i++)
      {
        userReviews.add({
          'name': userReviewJsonResults[i]['author'],
          'review_content': userReviewJsonResults[i]['content'],
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

    // Movie Trailers
    var movieTrailersResponse = await http.get(Uri.parse(ApiLink.itemTrailerUrl(widget.itemId.toString(), 'movie')));

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
      }
      //trailerList.add({'key': 'aJ0cZTcTh90'});
    } 
    else
    {
      print("Error: ${movieTrailersResponse.statusCode}:${movieTrailersResponse.reasonPhrase}");
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(context); // Call checkConnectivity when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(currentState: "MovieDetailsPage"),
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: movieDetails(),
        builder: (context, snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done)
          {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                 automaticallyImplyLeading: false,
                  leading: IconButton(
                      onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 28,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                  centerTitle: false,
                  pinned: true,

                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FittedBox(
                      fit: BoxFit.fill,
                      child: trailerList.isNotEmpty
                        ? WatchTrailer(trailerList[0]['key'])
                        : itemDetails[0]['backdrop_path'] != null ?
                        Image.network(
                            // Use the backdrop_path if trailerList is empty
                            '${ApiConstants.baseImageUrl}${itemDetails[0]['backdrop_path']}',
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/default_backdrop.jpg')
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        // Title
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16,right: 8,top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(itemDetails[0]['title'], style: Theme.of(context).textTheme.bodyLarge),
                                IconButton(
                                  onPressed: () {
                                    shareItem();
                                  },
                                  icon: Icon(Icons.share),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        // Add to list Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ListActionButton("Add to Watch List", Icons.add, () {
                              addToWatchList(widget.itemId);
                            }),
                            ListActionButton("Add to Watched List", Icons.add, () {
                              addToWatchedList(widget.itemId);
                            }),
                          ]
                        ),
                        // Display Genres
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: genresList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(25, 25, 25, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(genresList[index].toString(), style: Theme.of(context).textTheme.labelMedium)
                                  );
                                }
                                ),
                            )
                          ],
                        ),

                        // Run time
                        itemDetails[0]['runtime'] > 0
                        ? Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10, top: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                      color: Color.fromRGBO(25, 25, 25, 1),
                                      borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(itemDetails[0]['runtime'].toString() + ' minutes', style: Theme.of(context).textTheme.labelMedium)
                            
                            )
                          ],
                        )
                        :SizedBox.shrink(),
                      ],
                    ),

                    // Overview section
                    itemDetails[0]['overview'].isNotEmpty
                    ? Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(itemDetails[0]['overview'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    )
                    : SizedBox.shrink(),
                    
                    // Review Section
                    Padding(
                      padding: EdgeInsets.only(left:20, top:10),
                      child: UserReview(userReviews), //Text(userReviews.isNotEmpty.toString()),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Release Date : '+ itemDetails[0]['release_date'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Budget : \$'+ itemDetails[0]['budget'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Revenue : \$'+ itemDetails[0]['revenue'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    similarItems.isNotEmpty
                    ? SliderList(similarItems, "More Movies Like This", itemDetails[0]['media_type'], similarItems.length)
                    : SizedBox.shrink(),

                    recommendedItems.isNotEmpty
                    ? SliderList(recommendedItems, "Recomended For You", itemDetails[0]['media_type'], recommendedItems.length)
                    : SizedBox.shrink(),
                    
                   ])
                )
              ]
            );
          }
          else if (snapshot.hasError) 
          {
            // Handle the error state
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } 
          else
          {
            return Center(
              child: CircularProgressIndicator(
              ),
            );

          }
        }
      ),
    );
  }

  void shareItem() async {
  final url = 'https://www.themoviedb.org/movie/${widget.itemId}';
  
  try {
    // Attempt to copy the URL to the clipboard
    await Clipboard.setData(ClipboardData(text: url));
    // If successful, show a success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Movie URL copied to clipboard: $url'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    // If copying to clipboard fails, fall back to sharing using share_plus package
    Share.share('Check out this movie on TMDB: $url');
  }
}
}