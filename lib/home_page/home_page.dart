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

class _HomePageState extends State<HomePage>
{
  List<Map<String, dynamic>> trendingList = [];

  Future<void> trendinglisthome() async
  {
    var trendingResponse = await http.get(Uri.parse(ApiLink.trendingMovieDayUrl));
    print('Response Status Code: ${trendingResponse.statusCode}');
    //print('Response Body: ${trendingResponse.body}');

    if (trendingResponse.statusCode == 200)
    {
      
      var tempData = jsonDecode(trendingResponse.body);
      var trendingMovieJson = tempData['results'];
      
      for (var i = 0; i< trendingMovieJson.length; i++)
      {
        print("Enter");
        trendingList.add({
          'id': trendingMovieJson[i]['id'],
          'poster_path': trendingMovieJson[i]['poster_path'],
          'vote_average': trendingMovieJson[i]['vote_average'],
          'media_type': trendingMovieJson[i]['media_type'],
          'indexno': i,
        });
      }

    }
  }

  int uval = 1;

  @override
  Widget build(BuildContext context)
  {
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
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds:2),
                        height: MediaQuery.of(context).size.height),
                        items: trendingList.map((i){
                          return Builder(builder: (BuildContext context){
                            return GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                      image: NetworkImage('${ApiConstants.baseImageUrl}${i['poster_path']}'),
                                      fit: BoxFit.fill,
                                    )
                                  ),
                                ),),
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