import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:flutter/material.dart';

Widget SliderList(List itemList, String title, String itemType, int itemCount)
{
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 10),
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
                      print("${itemList[index]['id']}, $itemType");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionCheckUi(
                                itemList[index]['id'], 
                                itemType,)
                          ));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                              image: itemList[index]['poster_path'] != null
                                  ? NetworkImage('${ApiConstants.baseImageUrl}${itemList[index]['poster_path']}') as ImageProvider
                                  : AssetImage('assets/images/default_poster.jpg')  as ImageProvider,
                              fit: BoxFit.cover)),
                      margin: EdgeInsets.only(left: 13),
                      width: 170,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 9, left: 12),
                                child: Text(itemList[index]['release_date'].substring(0, 4), style: Theme.of(context).textTheme.titleMedium,)),
                            Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 9, right: 12),
                                child: Row(
                                            // Rating
                                            children: [
                                              Icon(Icons.star,
                                                  size: 15),
                                              SizedBox(width: 2),
                                              Text(itemList[index]['vote_average'].toString(), style: Theme.of(context).textTheme.titleMedium,)
                                            ])
                                            
                                            )
                          ])
                          ));
            })),
    SizedBox(height: 20)
  ]);
} 