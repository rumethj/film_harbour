import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';

class Popular extends StatefulWidget {
  final String uSelection; // Declare the String variable

  const Popular({Key? key, required this.uSelection}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState(uSelection: uSelection);
}

class _PopularState extends State<Popular> {
  String uSelection;
  List<Map<String, dynamic>> popularList = [];

  _PopularState({required this.uSelection});

  

  // Fill Popular List
  Future<void> popularListFunction() async
  {
    if (uSelection == 'movie')
    {
      print('got into movie');
      var popularMovieResponse = await http.get(Uri.parse(ApiLink.moviePopularUrl));
      //print('Response Status Code: ${popularMovieResponse.statusCode}');
      //print('Response Body: ${popularMovieResponse.body}');
      if (popularMovieResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(popularMovieResponse.body);
        var poularMovieJson = tempData['results'];
        
        for (var i = 0; i< poularMovieJson.length; i++)
        {
          popularList.add({
            'id': poularMovieJson[i]['id'],
            'title': poularMovieJson[i]['title'],
            'poster_path': poularMovieJson[i]['poster_path'],
            'vote_average': poularMovieJson[i]['vote_average'],
            'indexno': i,
            'date': poularMovieJson[i]['release_date'],
          });
        }
      }
      else
      {
        print("Error: ${popularMovieResponse.statusCode}:${popularMovieResponse.reasonPhrase}");
      }
      
    }
    else if (uSelection == 'tv')
    {
      print('got into tv');
      var popularTvResponse = await http.get(Uri.parse(ApiLink.tvPopularUrl));
      print('Response Status Code: ${popularTvResponse.statusCode}');
      //print('Response Body: ${popularTvResponse.body}');
      if (popularTvResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(popularTvResponse.body);
        var popularTvJson = tempData['results'];
        
        for (var i = 0; i< popularTvJson.length; i++)
        {
          popularList.add({
            'id': popularTvJson[i]['id'],
            'title': popularTvJson[i]['name'],
            'poster_path': popularTvJson[i]['poster_path'],
            'vote_average': popularTvJson[i]['vote_average'],
            'indexno': i,
            'date': popularTvJson[i]['first_air_date'],
          });
        }
      }
      else
      {
        print("Error: ${popularTvResponse.statusCode}:${popularTvResponse.reasonPhrase}");
      }
    }     
  }

  // Update popular List
  void updatePopularList() {
    setState(() {
      popularList.clear(); // Clear the list before updating
      popularListFunction(); // Repopulate the list based on the user's selection
    });
  }

  @override
  void didUpdateWidget(covariant Popular oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (uSelection != widget.uSelection) {
      // The uSelection parameter has changed, trigger a rebuild
      setState(() {
        uSelection = widget.uSelection;
        updatePopularList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Popular Widget Rebuilt with uSelection: $uSelection');
    return FutureBuilder(
      future: popularListFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Colors.amber.shade400),
          );
        }
        else
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
                child: Text("Popular"),
                ),
              
              Flexible(
                child: Container(
                  //height: 250,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180, // Adjust this value based on your desired width
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 2 / 3, // Set the aspect ratio to 2:3
                    ),
                    itemCount: popularList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(popularList[index]['title']);
                          if (uSelection == "movie")
                          {
                            print(popularList[index]['id']);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(popularList[index]['id']),));
                          }
                          else if (uSelection == 'tv')
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Placeholder()));//TvDetailsPage(popularList[index]['id']),));
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage('${ApiConstants.baseImageUrl}${popularList[index]['poster_path']}'),
                              fit: BoxFit.cover,
                            )
                          ),
                          // margin: EdgeInsets.only(left: 13), // Remove this line
                
                          // item info
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 6),
                                child: Text(popularList[index]['date'].substring(0, 4)),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 15,
                                        ),
                                        Text(popularList[index]['vote_average'].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                ),
                              
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}