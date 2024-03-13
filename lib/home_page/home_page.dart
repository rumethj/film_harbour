import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:film_harbour/home_page/tab_page/tab_page.dart';
import 'package:film_harbour/repeated_widgets/bottom_nav_bar.dart';
import 'package:film_harbour/repeated_widgets/search_bar_element2.dart';
import "package:flutter/material.dart";
import 'package:film_harbour/api_key/api_links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin
{

  List<Map<String, dynamic>> trendingList = [];

  Future<void> trendingListFunction() async
  {

    if (uSelection == 'movie')
    {
      var trendingMovieResponse = await http.get(Uri.parse(ApiLink.trendingMovieDayUrl));
      print('Response Status Code: ${trendingMovieResponse.statusCode}');
      //print('Response Body: ${trendingMovieResponse.body}');
      if (trendingMovieResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(trendingMovieResponse.body);
        var trendingMovieJson = tempData['results'];
        
        for (var i = 0; i< trendingMovieJson.length; i++)
        {
          print("Enter");
          trendingList.add({
            'id': trendingMovieJson[i]['id'],
            'title': trendingMovieJson[i]['title'],
            'poster_path': trendingMovieJson[i]['poster_path'],
            'vote_average': trendingMovieJson[i]['vote_average'],
            'media_type': trendingMovieJson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    }
    else if (uSelection == 'tv')
    {
      var trendingTvResponse = await http.get(Uri.parse(ApiLink.trendingTvDayUrl));
      print('Response Status Code: ${trendingTvResponse.statusCode}');
      //print('Response Body: ${trendingTvResponse.body}');
      if (trendingTvResponse.statusCode == 200)
      {
        
        var tempData = jsonDecode(trendingTvResponse.body);
        var trendingTvJson = tempData['results'];
        
        for (var i = 0; i< trendingTvJson.length; i++)
        {
          print("Enter");
          trendingList.add({
            'id': trendingTvJson[i]['id'],
            'title': trendingTvJson[i]['name'],
            'poster_path': trendingTvJson[i]['poster_path'],
            'vote_average': trendingTvJson[i]['vote_average'],
            'media_type': trendingTvJson[i]['media_type'],
            'indexno': i,
          });
        }
      }     
    }


    
  }

  // Movie/Tv Selector
  String uSelection = 'movie';

  @override
  Widget build(BuildContext context)
  {
    print('Parent Widget Rebuilt with userSelection: $uSelection');
    TabController _tabController = TabController(length: 7, vsync: this);

    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(currentState: "HomePage"),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height*0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: trendingListFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done){
                    return CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.2,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds:3),
                          height: MediaQuery.of(context).size.height),
                          items: trendingList.map((i){
                            int index = trendingList.indexOf(i); // Get the index of the current item
                            return Builder(builder: (BuildContext context){
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionCheckUi(trendingList[index]['id'], uSelection)));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0), // need adjustments
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                                image: NetworkImage('${ApiConstants.baseImageUrl}${i['poster_path']}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                      
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.black.withOpacity(0.5),
                                              child: Text(
                                                '${i['title']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              );
                            });
                          }).toList(),
                      
                    );
                  } 
                  else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                        )
                    );
                  }
                },
              ),
            ),

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trending',
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
                              trendingList.clear(); //clear lists top update fields
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
                                'Movies',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'movie',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Tv Shows',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'tv',
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),   
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              
              // Search Bar
              SearchBarNew(),

              // Tab Bar
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    controller: _tabController,
                    physics: BouncingScrollPhysics(),
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.amber.withOpacity(0.4),
                    ),
                    tabs: const [
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Discover'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Popular'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Upcoming'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Top Grossing'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Showing Now'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('For Kids'))),
                      Tab(child: Padding(
                        padding: EdgeInsets.only(left:15.0, right: 15.0),
                        child: Text('Best of the Year'))),
                    ],
                    padding: EdgeInsets.only(bottom: 16.0),
                  ),
                  
              ),
              
              Container(
                height: 1050,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // use parameters to define tv shows or movies
                    TabPage(uSelection: uSelection, tabCategory:'discover' ),
                    TabPage(uSelection: uSelection, tabCategory:'popular' ),
                    TabPage(uSelection: uSelection, tabCategory:'upcoming' ),
                    TabPage(uSelection: uSelection, tabCategory:'topGrossing' ),
                    TabPage(uSelection: uSelection, tabCategory:'showingNow' ),
                    TabPage(uSelection: uSelection, tabCategory:'forKids' ),
                    TabPage(uSelection: uSelection, tabCategory:'yearBest' ),
                  ],
                ),
              ),
            ])
          )
        ],
      ),
    );
  }


  // Update userSelection and trigger a rebuild of the Popular widget
  void updateUserSelection(String newItemSelection) {
    setState(() {
      uSelection = newItemSelection;
    });
    // Now, the Popular widget will be rebuilt with the updated userSelection
  }
}