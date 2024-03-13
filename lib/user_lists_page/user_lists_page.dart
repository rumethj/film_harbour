import 'dart:convert';
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:film_harbour/repeated_widgets/bottom_nav_bar.dart';
import 'package:film_harbour/repeated_widgets/user_list_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class UserListsPage extends StatefulWidget {
  const UserListsPage({super.key});

  @override
  State<UserListsPage> createState() => _UserListsPageState();
}

class _UserListsPageState extends State<UserListsPage> {
  List<Map<String, dynamic>> userList = [];

  Future<void> userListFunction() async
  {
    if (uSelection == 'watch')
    {
      List<int> watchList = await readWatchList();
      watchList.add(
        1096197
      );
      watchList.add(
        932420
      );
      watchList.add(
        792307
      );
      watchList.add(
        969492
      );
      for (int i = 0; i < watchList.length; i++)
      {
        var movieDetailsResponse = await http.get(Uri.parse(ApiLink.itemDetailsUrl(watchList[i].toString(), 'movie')));
        print('Response Status Code: ${movieDetailsResponse.statusCode}');
        if (movieDetailsResponse.statusCode == 200)
        {
            
          //var tempData = jsonDecode(movieDetailsResponse.body);
          var movieDetailsJsonResults = jsonDecode(movieDetailsResponse.body);

            userList.add({
              'id': watchList[i],
              'backdrop_path': movieDetailsJsonResults['backdrop_path'],
              'title': movieDetailsJsonResults['title'],
              'poster_path': movieDetailsJsonResults['poster_path'],
              'vote_average': movieDetailsJsonResults['vote_average'] ?? 'N/A',
              'date': movieDetailsJsonResults['release_date'] ?? 'N/A',
              'media_type': 'movie',
            });
        } 
        else
        {
          var tvDetailsResponse = await http.get(Uri.parse(ApiLink.itemDetailsUrl(watchList[i].toString(), 'tv')));
          print('Response Status Code: ${tvDetailsResponse.statusCode}');
          if (tvDetailsResponse.statusCode == 200)
          {
              
            //var tempData = jsonDecode(tvDetailsResponse.body);
            var tvDetailsJsonResults = jsonDecode(tvDetailsResponse.body);

              userList.add({
                'id': watchList[i],
                'backdrop_path': tvDetailsJsonResults['backdrop_path'],
                'title': tvDetailsJsonResults['name'],
                'poster_path': tvDetailsJsonResults['poster_path'],
                'vote_average': tvDetailsJsonResults['vote_average'] ?? 'N/A',
                'date': tvDetailsJsonResults['release_date'] ?? 'N/A',
                'media_type': 'tv',
              });
          } 
          else
          {
            print("Error: ${tvDetailsResponse.statusCode}:${tvDetailsResponse.reasonPhrase}");
          }
        }

      }

    }
    else if (uSelection == 'watched')
    {

    }
  }

  // watch/watched selector
  String uSelection = 'watch';

  @override
  Widget build(BuildContext context)
  {
    print('Parent Widget Rebuilt with userSelection: $uSelection');

    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(currentState: "UserListsPage"),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 50,
            pinned: true,
            //expandedHeight: MediaQuery.of(context).size.height*0.5,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your List',
                  style:TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 16)),
                    SizedBox(width: 10),

                    // Dropdown
                    Container(
                      height: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton(
                          onChanged: (value){
                            setState(() {
                              userList.clear(); //clear lists top update fields
                              uSelection = value.toString();
                              updateUserSelection(value!);
                            });
                            
                          },

                          autofocus: true,
                          underline: Container(height: 0, color: Colors.transparent,),
                          dropdownColor: Colors.black.withOpacity(0.6),

                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.amber,
                            size: 30,
                          ),

                          value: uSelection,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'Watch List',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'watch',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Watched List',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'watched',
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),   
          ),
          
          // Grid view of list
        //   SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
        //     child: Text("Popular"),
        //   ),
        // ),

        // Grid view of list
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: userListFunction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.amber.shade400),
                  );
                } else {
                  return GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: userList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(userList[index]['title']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionCheckUi(userList[index]['id'], userList[index]['media_type']),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage('${ApiConstants.baseImageUrl}${userList[index]['poster_path']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 6),
                                child: Text(userList[index]['date'].substring(0, 4)),
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
                                        Text(userList[index]['vote_average'].toString()),
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
                  );
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}

  // Update userSelection and trigger a rebuild of the Popular widget
  void updateUserSelection(String newSelection) {
    setState(() {
      uSelection = newSelection;
    });
    // Now, the Popular widget will be rebuilt with the updated userSelection
  }
}