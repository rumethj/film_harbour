import 'package:film_harbour/details_page/movie_details_page.dart';
import 'package:film_harbour/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/details_page/checker.dart';
import 'package:http/http.dart' as http;
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:film_harbour/api_key/api_links.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:film_harbour/repeated_widgets/search_results_page.dart';

class SearchBarNew extends StatefulWidget {
  const SearchBarNew({super.key});

  @override
  State<SearchBarNew> createState() => _SearchBarNewState();
}

class _SearchBarNewState extends State<SearchBarNew> {

  //List<Map<String, dynamic>> searchResult = [];
  final TextEditingController searchText = TextEditingController();

  double searchResultsContainerHeight = 0.0;

  bool showList = false;
  var searchValue;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: searchText,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: CustomTheme.mainPalletRed),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: CustomTheme.mainPalletRed),
                onPressed: () {
                  setState(() {
                    searchText.clear();
                    //searchResult.clear();
                  });
                },
              ),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.labelLarge,
              filled: true,
              fillColor: CustomTheme.mainPalletBlue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),


            onChanged: (value) {
              //searchResult.clear();

              // setState(() {
              //   searchValue = value;
              // });
            },
            onSubmitted: (value) {
              //searchResult.clear();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultsPage(searchQuery: value,),
                ),
              );

              //SearchList(value);
            },
          ),
        ],
      ),
    );
  }
}