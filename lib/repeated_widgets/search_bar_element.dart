import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:http/http.dart' as http;
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  List<Map<String, dynamic>> searchResult = [];
  final TextEditingController searchText = TextEditingController();

  bool showList = false;
  var searchValue;

  Future<void> SearchList(String value) async
  {
    var searchResponse = await http.get(Uri.parse(ApiLink.searchUrl(value)));

    if (searchResponse.statusCode == 200) 
    {
      var tempdata = jsonDecode(searchResponse.body);
      var searchJson = tempdata['results'];

      for (var i = 0; i < searchJson.length; i++) {
        //only add value if all are present
        if (searchJson[i]['id'] != null &&
            searchJson[i]['poster_path'] != null &&
            searchJson[i]['vote_average'] != null &&
            searchJson[i]['media_type'] != null) 
        {
          searchResult.add({
            'id': searchJson[i]['id'],
            'poster_path': searchJson[i]['poster_path'],
            'vote_average': searchJson[i]['vote_average'],
            'media_type': searchJson[i]['media_type'],
            'popularity': searchJson[i]['popularity'],
            'overview': searchJson[i]['overview'],
          });

          // searchResult = searchResult.toSet().toList();
          // trim results
          if (searchResult.length > 20) 
          {
            searchResult.removeRange(20, searchResult.length);
          }
        } else {
          print('Null found');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print("tapped");
        FocusManager.instance.primaryFocus?.unfocus();
        showList = !showList;
      },
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  autofocus: false,
                  controller: searchText,
                  onSubmitted: (value) {
                    searchResult.clear();
                    setState(() {
                      searchValue = value;
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  onChanged: (value) {
                    searchResult.clear();

                    setState(() {
                      searchValue = value;
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              webBgColor: "#000000",
                              webPosition: "center",
                              webShowClose: true,
                              msg: "Search Cleared",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color.fromRGBO(18, 18, 18, 1),
                              textColor: Colors.white,
                              fontSize: 16.0);

                          setState(() {
                            searchText.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        icon: Icon(
                          Icons.clear_all_rounded,
                          color: Colors.amber.withOpacity(0.6),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.amber,
                      ),
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.2)),
                      border: InputBorder.none),
                ),
              ),
              //
              //
              SizedBox(
                height: 5,
              ),

              //if textfield has focus and search result is not empty then display search result

              searchText.text.length > 0
                  ? FutureBuilder(
                      future: SearchList(searchValue),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: searchResult.length,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                        DescriptionCheckUi(
                                                          searchResult[index]
                                                              ['id'],
                                                          searchResult[index]
                                                              ['media_type'],
                                                      )
                                                     )
                                                      );
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 4, bottom: 4),
                                            height: 180,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    20, 20, 20, 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width *0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    image: DecorationImage(
                                                        //color filter

                                                        image: NetworkImage(
                                                            '${ApiConstants.baseImageUrl}${searchResult[index]['poster_path']}'),
                                                        fit: BoxFit.fill)),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                        ///////////////////////
                                                        //media type
                                                        Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Text(
                                                            '${searchResult[index]['media_type']}',
                                                          ),
                                                        ),

                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              //vote average box
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 30,
                                                                // width:
                                                                //     100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .amber
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(6))),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          '${searchResult[index]['vote_average']}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),

                                                              //popularity
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .amber
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .people_outline_sharp,
                                                                        color: Colors
                                                                            .amber,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          '${searchResult[index]['popularity']}')
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),

                                                              //
                                                            ],
                                                          ),
                                                        ),

                                                        Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            height: 85,
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                ' ${searchResult[index]['overview']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)))
                                                      ])))
                                            ]
                                            )
                                            )
                                            );
                                  }));
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.amber,
                          ));
                        }
                      })
                  : Container(),
            ],
          )),
    );
  }
}