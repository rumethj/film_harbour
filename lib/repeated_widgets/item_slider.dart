import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:flutter/material.dart';

Widget SliderList(List itemList, String title, String itemType, int itemCount)
{
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 40),
        child: Text(title)),
    Container(
        height: 250,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    if (itemType == 'movie') {
                      // print(firstlistname[index]['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailsPage(itemList[index]['id'])
                          ));
                    } else if (itemType == 'tv') {
                      // print(firstlistname[index]['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Placeholder()));//TvDetailsPage(itemList[index]['id'])));
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                              image: NetworkImage('${ApiConstants.baseImageUrl}${itemList[index]['poster_path']}'),
                              fit: BoxFit.cover)),
                      margin: EdgeInsets.only(left: 13),
                      width: 170,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 2, left: 6),
                                child: Text(itemList[index]['release_date'].substring(0, 4))),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 2, right: 6),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 5,
                                            right: 5),
                                        child: Row(
                                            // Rating
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.yellow,
                                                  size: 15),
                                              SizedBox(width: 2),
                                              Text(itemList[index]['vote_average'].toString())
                                            ]))))
                          ])));
            })),
    SizedBox(height: 20)
  ]);
} 