import 'package:film_harbour/details_page/person_details_page.dart';
import 'package:film_harbour/details_page/tv_details_page.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/details_page/movie_details_page.dart';

class DescriptionCheckUi extends StatefulWidget {

  var newId;
  var newType;
  
  DescriptionCheckUi(this.newId, this.newType);

  @override
  State<DescriptionCheckUi> createState() => _DescriptionCheckUiState();
}

class _DescriptionCheckUiState extends State<DescriptionCheckUi> {

  checkType()
  {
    if (widget.newType == 'movie')
    {
      return MovieDetailsPage(widget.newId);
    }
    else if (widget.newType == 'tv')
    {
      return TvDetailsPage(widget.newId);
    }
    else if (widget.newType == 'person')
    {
      return PersonDetailsPage(widget.newId);
    }
    else
    {
      return ErrorUi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return checkType();
  }
}

Widget ErrorUi()
{
  return const Scaffold(
    body: Center(
      child: Text("Error"),
    ),
  );
}