import 'package:film_harbour/api_key/api_constants.dart';
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

  Future<void> trendinglisthome() async
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


    
  }

  // Movie/Tv Selector
  String uSelection = 'movie';

  @override
  Widget build(BuildContext context)
  {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
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
                future: trendinglisthome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done){
                    return CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.2,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds:3),
                          height: MediaQuery.of(context).size.height),
                          items: trendingList.map((i){
                            return Builder(builder: (BuildContext context){
                              return GestureDetector(
                                onTap: () {},
                                child: GestureDetector(
                                  onTap: () {},
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                                'Movie',
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
              Center(
                child: Text("Sample Text"),
              )
            ])
          )
        ],
      ),
    );
  }
}