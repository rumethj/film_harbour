import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  
  List reviewDetails;

  UserReview(this.reviewDetails);

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    List reviewDetailsList = widget.reviewDetails;
    if (reviewDetailsList.length == 0) {
      return Center();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 10, top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'User Reviews',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Row(
                    children: [
                      // check if user wants to see all reviews
                      showAll == false
                          ? Text(
                              'All Reviews ' + '${reviewDetailsList.length} ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          // else/false
                          : Text(
                              'Show Less',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //
          //show only one review
          showAll == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    physics:  BouncingScrollPhysics(),
                      itemCount: reviewDetailsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        reviewDetailsList[index]
                                                            ['profileImage']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  reviewDetailsList[index]['name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                reviewDetailsList[index]
                                                    ['date'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              reviewDetailsList[index]['rating'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      reviewDetailsList[index]['review_content'],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }))
              : Container(
                  child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(reviewDetailsList[0]
                                                ['profileImage']),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          reviewDetailsList[0]['name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        reviewDetailsList[0]['date'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      reviewDetailsList[0]['rating'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              reviewDetailsList[0]['review_content'],
                            ),
                          )
                        ],
                      ),
                      //show more button
                    ],
                  ),
                ))
        ],
      );
    }
  }
}