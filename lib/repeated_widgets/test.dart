// import 'package:film_harbour/details_page/movie_details_page.dart';
// import 'package:flutter/material.dart';
// import 'package:film_harbour/details_page/checker.dart';
// import 'package:http/http.dart' as http;
// import 'package:film_harbour/api_key/api_constants.dart';
// import 'package:film_harbour/api_key/api_links.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';



// class _SearchBarNew2State extends State<SearchBarNew2> {
//   List<Map<String, dynamic>> searchResult = [];
//   final TextEditingController searchText = TextEditingController();

//   double searchResultsContainerHeight = 0.0;

//   Future<void> SearchList(String value) async {
//     // ... existing code for fetching search results ...
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               TextField(
//                 controller: searchText,
//                 // ... existing code for search bar ...
//                 onChanged: (value) {
//                   setState(() {
//                     searchResult.clear();
//                     searchResultsContainerHeight = 0.0;
//                   });
//                   // Other code...
//                 },
//                 onSubmitted: (value) async {
//                   setState(() {
//                     searchResult.clear();
//                     searchResultsContainerHeight = 0.0;
//                   });
//                   await SearchList(value);
//                   setState(() {
//                     // Set the height based on the number of search results or a fixed value
//                     searchResultsContainerHeight = searchResult.length * 50.0;
//                   });
//                 },
//               ),
//               Positioned(
//                 top: 60.0, // Adjust this value based on your UI design
//                 left: 0,
//                 right: 0,
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   height: searchResultsContainerHeight,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 1,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: FutureBuilder(
//                     // ... existing FutureBuilder code ...
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
