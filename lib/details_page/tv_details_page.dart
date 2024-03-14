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


class TvDetailsPage extends StatefulWidget {

  var itemId;

  TvDetailsPage(this.itemId);

  @override
  State<TvDetailsPage> createState() => _TvDetailsPageState();
}

class _TvDetailsPageState extends State<TvDetailsPage> {
  List<Map<String, dynamic>> itemDetails = [];

  List genresList = [];

  Future <void> tvDetails() async
  {
    // tv Details
    var tvDetailsResponse = await http.get(Uri.parse(ApiLink.itemDetailsUrl(widget.itemId.toString(), 'tv')));
    print('Response Status Code: ${tvDetailsResponse.statusCode}');
    if (tvDetailsResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(tvDetailsResponse.body);
      var tvDetailsJsonResults = jsonDecode(tvDetailsResponse.body);
        
      // for (var i = 0; i< 1; i++)
      // {
        itemDetails.add({
          'backdrop_path': tvDetailsJsonResults['backdrop_path'],
          'title': tvDetailsJsonResults['name'],
          'poster_path': tvDetailsJsonResults['poster_path'],
          'vote_average': tvDetailsJsonResults['vote_average'],
          'release_date': tvDetailsJsonResults['first_air_date'],
          'overview': tvDetailsJsonResults['overview'],
          'seasons': tvDetailsJsonResults['number_of_episodes'],
          'popularity': tvDetailsJsonResults['popularity'],
          'media_type': 'tv',
        });
      //}
      for (int i = 0; i<tvDetailsJsonResults['genres'].length; i++)
      {
        genresList.add(tvDetailsJsonResults['genres'][i]['name']);
      }
    } 
    else
    {
      print("Error: ${tvDetailsResponse.statusCode}:${tvDetailsResponse.reasonPhrase}");
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
      bottomNavigationBar: CustomNavigationBar(currentState: "tvDetailsPage"),
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: tvDetails(),
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

                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FittedBox(
                      fit: BoxFit.cover,
                      child: itemDetails[0]['backdrop_path'] != null 
                      ? Image.network(
                            // Use the backdrop_path if trailerList is empty
                            '${ApiConstants.baseImageUrl}${itemDetails[0]['backdrop_path']}',
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/default_backdrop.jpg', fit: BoxFit.cover)
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),

                    // Overview section
                    itemDetails[0]['overview'].isNotEmpty
                    ? Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(itemDetails[0]['overview'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    )
                    : SizedBox.shrink(),
                    
                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Release Date : '+ itemDetails[0]['release_date'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Seasons : '+ itemDetails[0]['seasons'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Vote Average : '+ itemDetails[0]['vote_average'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

                    Padding(  
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Popularity : '+ itemDetails[0]['popularity'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    ),

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
  final url = 'https://www.themoviedb.org/tv/${widget.itemId}';
  
  try {
    // Attempt to copy the URL to the clipboard
    await Clipboard.setData(ClipboardData(text: url));
    // If successful, show a success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('TV URL copied to clipboard: $url'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    print("Failed to copy to clipboard.");
  }
}
}