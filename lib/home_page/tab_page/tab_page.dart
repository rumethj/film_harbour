import 'package:film_harbour/details_page/checker.dart';
import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';

class TabPage extends StatefulWidget {
  final String uSelection;
  final String tabCategory; 

  const TabPage({Key? key, required this.uSelection, required this.tabCategory}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState(uSelection: uSelection, tabCategory: tabCategory);
}

class _TabPageState extends State<TabPage> {
  String uSelection;
  String tabCategory; 
  

  List<Map<String, dynamic>> itemList = [];

  _TabPageState({required this.uSelection, required this.tabCategory});

  String uSortSelection = 'release_date.desc';

  // Fill Popular List
  Future<void> tabItemListFunction() async
  {
    

    if (uSelection == 'movie')
    {
      var movieResponse;

      if (tabCategory == 'discover')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.discoverUrl(uSelection, uSortSelection)));
      }
      else if (tabCategory == 'popular')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.popularUrl(uSelection)));
      }
      else if (tabCategory == 'upcoming')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.upcomingMovieUrl));
      }
      else if (tabCategory == 'topGrossing')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.topGrossingUrl(uSelection)));
      }
      else if (tabCategory == 'showingNow')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.showingOnCinemaUrl));
      }
      else if (tabCategory == 'forKids')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.forKidsUrl(uSelection)));
      }
      else if (tabCategory == 'yearBest')
      {
        movieResponse = await http.get(Uri.parse(ApiLink.bestMoviesUrl));
      }
      //print('Response Status Code: ${movieResponse.statusCode}');
      //print('Response Body: ${movieResponse.body}');
      if (movieResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(movieResponse.body);
        var movieJson = tempData['results'];
        
        for (var i = 0; i< movieJson.length; i++)
        {
          if (movieJson[i]['poster_path'] != null)
          {
              itemList.add({
            'id': movieJson[i]['id'],
            'title': movieJson[i]['title'],
            'poster_path': movieJson[i]['poster_path'],
            'vote_average': movieJson[i]['vote_average'],
            'indexno': i,
            'date': movieJson[i]['release_date'],
            });
          }
        }
      }
      else
      {
        print("Error: ${movieResponse.statusCode}:${movieResponse.reasonPhrase}");
      }
      
    }
    else if (uSelection == 'tv')
    {
      var tvResponse;

      if (tabCategory == 'discover')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.discoverUrl(uSelection, uSortSelection)));
      }
      else if (tabCategory == 'popular')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.popularUrl(uSelection)));
      }
      else if (tabCategory == 'upcoming')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.upcomingTvShowUrl));
      }
      else if (tabCategory == 'topGrossing')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.topGrossingUrl(uSelection)));
      }
      else if (tabCategory == 'showingNow')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.showingOnTVUrl));
      }
      else if (tabCategory == 'forKids')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.forKidsUrl(uSelection)));
      }
      else if (tabCategory == 'yearBest')
      {
        tvResponse = await http.get(Uri.parse(ApiLink.bestTvShowsUrl));
      }

      //var tvResponse = await http.get(Uri.parse(ApiLink.tvPopularUrl));
      print('Response Status Code: ${tvResponse.statusCode}');
      //print('Response Body: ${tvResponse.body}');
      if (tvResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(tvResponse.body);
        var tvJson = tempData['results'];
        
        for (var i = 0; i< tvJson.length; i++)
        {
          if (tvJson[i]['poster_path'] != null)
          {
            itemList.add({
            'id': tvJson[i]['id'],
            'title': tvJson[i]['name'],
            'poster_path': tvJson[i]['poster_path'],
            'vote_average': tvJson[i]['vote_average'],
            'indexno': i,
            'date': tvJson[i]['first_air_date'],
          });
          }
        }
      }
      else
      {
        print("Error: ${tvResponse.statusCode}:${tvResponse.reasonPhrase}");
      }
    }     
  }

  // Update popular List
  void updateitemList() {
    setState(() {
      itemList.clear(); // Clear the list before updating
      tabItemListFunction(); // Repopulate the list based on the user's selection
    });
  }

  @override
  void didUpdateWidget(covariant TabPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (uSelection != widget.uSelection) {
      // The uSelection parameter has changed, trigger a rebuild
      setState(() {
        uSelection = widget.uSelection;
        updateitemList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Popular Widget Rebuilt with uSelection: $uSelection');
    return FutureBuilder(
      future: tabItemListFunction(),
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
              tabCategory == 'discover'
              ? // Dropdown
                Center(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DropdownButton(
                        onChanged: (value){
                          setState(() {
                            itemList.clear(); //clear lists top update fields
                            uSortSelection = value.toString();
                            updateUserSortSelection(value!);
                          });
                          
                        },
                  
                        autofocus: true,
                        underline: Container(height: 0, color: Colors.transparent,),
                        dropdownColor: Colors.black.withOpacity(0.6),
                  
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: CustomTheme.mainPalletRed,
                          size: 30,
                        ),
                  
                        value: uSortSelection,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Newest',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            value: 'release_date.desc',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Oldest',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            value: 'release_date.asc',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Alphabetical A - Z',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            value: 'title.asc',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Alphabetical Z - A',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            value: 'title.desc',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Rating',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            value: 'rating',
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
              
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
                    itemCount: itemList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(itemList[index]['title']);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionCheckUi(itemList[index]['id'], uSelection)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage('${ApiConstants.baseImageUrl}${itemList[index]['poster_path']}'),
                              fit: BoxFit.cover,
                            )
                          ),
                          // margin: EdgeInsets.only(left: 13), // Remove this line
                
                          // item info
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 9, left: 12),
                                child: Text(itemList[index]['date'].substring(0, 4), style: Theme.of(context).textTheme.titleMedium,),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 9, right: 12),
                                child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 15,
                                        ),
                                        SizedBox(width: 3,),
                                        Text(itemList[index]['vote_average'].toString(), style: Theme.of(context).textTheme.titleMedium,),
                                      ],
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


  // Update userSelection and trigger a rebuild of the Popular widget
  void updateUserSortSelection(String newSortSelection) {
    setState(() {
      uSortSelection = newSortSelection;
    });
    // Now, the Popular widget will be rebuilt with the updated userSelection
  }
}