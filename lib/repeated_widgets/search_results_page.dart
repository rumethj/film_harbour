import 'package:film_harbour/repeated_widgets/search_bar_element2.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:http/http.dart' as http;
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';
import 'dart:convert';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {

  List<Map<String, dynamic>> searchResult = [];
  final TextEditingController searchText = TextEditingController();

  Future<void> SearchList(String value) async
  {
    var searchResponse = await http.get(Uri.parse(ApiLink.searchUrl(value)));
    print("Searching for: $value");


    if (searchResponse.statusCode == 200) 
    {
      var tempdata = jsonDecode(searchResponse.body);
      var searchJson = tempdata['results'];

      for (var i = 0; i < searchJson.length; i++) {
        //only add value if all are present
        if (searchJson[i]['id'] != null &&
            (searchJson[i]['poster_path'] != null || searchJson[i]['profile_path'] != null )&&
            searchJson[i]['media_type'] != null &&
            searchJson[i]['popularity'] != null &&
            (searchJson[i]['overview'] != null || searchJson[i]['known_for_department'] != null)
            ) 
        {
          print("this is item: $i");
          if (searchJson[i]['media_type'] == 'movie')
          {
            searchResult.add({
            'id': searchJson[i]['id'],
            'title': searchJson[i]['title'],
            'poster_path': searchJson[i]['poster_path'],
            'vote_average': searchJson[i]['vote_average'],
            'media_type': searchJson[i]['media_type'],
            'popularity': searchJson[i]['popularity'],
            'overview': searchJson[i]['overview'],
            });
          }
          else if(searchJson[i]['media_type'] == 'tv')
          {
            searchResult.add({
            'id': searchJson[i]['id'],
            'title': searchJson[i]['name'],
            'poster_path': searchJson[i]['poster_path'],
            'vote_average': searchJson[i]['vote_average'],
            'media_type': searchJson[i]['media_type'],
            'popularity': searchJson[i]['popularity'],
            'overview': searchJson[i]['overview'],
          });
          }
          else if(searchJson[i]['media_type'] == 'person')
          {
            searchResult.add({
            'id': searchJson[i]['id'],
            'title': searchJson[i]['name'],
            'poster_path': searchJson[i]['profile_path'],
            'media_type': searchJson[i]['media_type'],
            'popularity': searchJson[i]['popularity'],
            'overview': searchJson[i]['known_for_department'],
          });
          }
          

          // searchResult = searchResult.toSet().toList();
          // trim results
          if (searchResult.length > 20) 
          {
            searchResult.removeRange(20, searchResult.length);
          }
        } 
        else 
        {
          print('Null found');
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    searchText.text = widget.searchQuery;
    SearchList(widget.searchQuery);
    checkConnectivity(context); // Call checkConnectivity when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarNew()
      ),
      body: FutureBuilder(
        future: SearchList(searchText.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                // Result items
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionCheckUi(
                            searchResult[index]['id'],
                            searchResult[index]['media_type'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Poster
                          Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${ApiConstants.baseImageUrl}${searchResult[index]['poster_path']}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8,),
                                // Movie Title
                                Text(
                                  searchResult[index]['title'],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(height: 5),
                                // Movie Overview
                                Text(
                                  '${searchResult[index]['overview']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SizedBox(height: 5),
                                // Movie Popularity
                                Text('Popularity: ${searchResult[index]['popularity']}',
                                  style: Theme.of(context).textTheme.labelMedium,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } 
          else 
          {
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
          }
        },
      ),
    );
  }
}