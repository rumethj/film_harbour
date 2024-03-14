import 'package:film_harbour/api_key/api_links.dart';
import 'package:film_harbour/home_page/home_page.dart';
import 'package:film_harbour/repeated_widgets/bottom_nav_bar.dart';
import 'package:film_harbour/repeated_widgets/item_slider.dart';
import 'package:film_harbour/repeated_widgets/user_list_action.dart';
import 'package:film_harbour/repeated_widgets/user_review_element.dart';
import 'package:film_harbour/utils/network/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:film_harbour/api_key/api_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:film_harbour/repeated_widgets/trailer_element.dart';
import 'package:share_plus/share_plus.dart';


class PersonDetailsPage extends StatefulWidget {

  var itemId;

  PersonDetailsPage(this.itemId);

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  List<Map<String, dynamic>> itemDetails = [];

  Future <void> personDetails() async
  {
    // person Details
    var personDetailsResponse = await http.get(Uri.parse(ApiLink.itemDetailsUrl(widget.itemId.toString(), 'person')));
    print('Response Status Code: ${personDetailsResponse.statusCode}');
    if (personDetailsResponse.statusCode == 200)
    {
        
      //var tempData = jsonDecode(personDetailsResponse.body);
      var personDetailsJsonResults = jsonDecode(personDetailsResponse.body);
        
      // for (var i = 0; i< 1; i++)
      // {
        itemDetails.add({
          'backdrop_path': personDetailsJsonResults['profile_path'],
          'title': personDetailsJsonResults['name'],
          'poster_path': personDetailsJsonResults['poster_path'],
          'overview': personDetailsJsonResults['known_for_department'],
          'popularity': personDetailsJsonResults['popularity'],
          'media_type': 'person',
        });
  
    } 
    else
    {
      print("Error: ${personDetailsResponse.statusCode}:${personDetailsResponse.reasonPhrase}");
    }

  }

  @override
  void initState() {
    super.initState();
    checkConnectivity(context); // Call checkConnectivity when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(currentState: "personDetailsPage"),
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: personDetails(),
        builder: (context, snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done)
          {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                 automaticallyImplyLeading: false,
                  leading: IconButton(
                      onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 28,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                  centerTitle: false,
                  pinned: true,

                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FittedBox(
                      fit: BoxFit.cover,
                      child: itemDetails[0]['backdrop_path'] != null 
                      ? Image.network(
                            // Use the backdrop_path if trailerList is empty
                            '${ApiConstants.baseImageUrl}${itemDetails[0]['backdrop_path']}',
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/default_backdrop.jpg', fit: BoxFit.cover)
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        // Title
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16,right: 8,top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(itemDetails[0]['title'], style: Theme.of(context).textTheme.bodyLarge),
                                IconButton(
                                  onPressed: () {
                                    shareItem();
                                  },
                                  icon: Icon(Icons.share),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Overview section
                    itemDetails[0]['overview'].isNotEmpty
                    ? Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Role : '+ itemDetails[0]['overview'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    )
                    : SizedBox.shrink(),

                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Popularity : '+ itemDetails[0]['popularity'].toString(), style: Theme.of(context).textTheme.headlineLarge),
                    )
                   

                   ])
                )
              ]
            );
          }
          else if (snapshot.hasError) 
          {
            // Handle the error state
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } 
          else
          {
            return Center(
              child: CircularProgressIndicator(
              ),
            );

          }
        }
      ),
    );
  }

  void shareItem() async {
  final url = 'https://www.themoviedb.org/person/${widget.itemId}';
  
  try {
    // Attempt to copy the URL to the clipboard
    await Clipboard.setData(ClipboardData(text: url));
    // If successful, show a success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('person URL copied to clipboard: $url'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  } catch (e) {
    print("Failed to copy to clipboard.");
  }
}
}