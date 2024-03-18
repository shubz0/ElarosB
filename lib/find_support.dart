import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/LocationModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FindSupportPage extends StatefulWidget {
  @override
  _FindSupportPageState createState() => _FindSupportPageState();
}

Future<List<Location>> fetchLocations() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Location> locations = [];
  try {
    QuerySnapshot snapshot = await firestore.collection('locations').get();
    print("Documents fetched: ${snapshot.docs.length}");
    for (var doc in snapshot.docs) {
      Location location =
          Location.fromFirestore(doc.data() as Map<String, dynamic>);
      locations.add(location);
    }
    return locations;
  } catch (e) {
    print("Error Fetching Locations: $e");
    throw e;
  }
}

class _FindSupportPageState extends State<FindSupportPage> {
  final TextEditingController _controller = TextEditingController();
  List<Location> _sortedLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 11, 83,
                      81), //find support page title container color
                  Color.fromARGB(255, 0, 169, 165),
                ],
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Find Support Page",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(
                      255, 144, 194, 231), //background color of the whole page
                  Colors.white,
                ],
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "We're here to Support you in All Ways Possible. We can Locate the nearest Clinic to you for an In Person Assessment. Start by entering your Postcode.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter Your Postcode",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: _searchLocations,
                    child: Text(
                      "Search",
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 11, 83, 81)), //search btn color
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(
                                0xff3C5C6C); //color of text on btn press
                          return Colors.white; //default color of text in btn
                        })),
                  ),
                  SizedBox(height: 5), //padding below the search btn
                  Expanded(
                      child: Container(
                          //container for search results
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 215, 213, 213),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _sortedLocations.isEmpty
                              ? Center(
                                  child: Text(
                                    'Your nearest clinics will be displayed here',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _sortedLocations.length,
                                  itemBuilder: (context, index) {
                                    final location = _sortedLocations[index];
                                    return ListTile(
                                      title: Text(
                                        location.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "Distance: ${location.distance.toStringAsFixed(2)} miles",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ))),

                  Divider(
                    height: 20,
                    thickness: 4,
                    color: Color.fromARGB(255, 11, 83, 81),
                  ),
                  Container(
                    //contact us container
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(255, 11, 83, 81),
                          Color.fromARGB(255, 0, 169, 165)
                        ])),
                    //      color: Color(0xff3C5C6C),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Us',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        SizedBox(height: 10),
                        Text(
                          'Email: contact@example.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Phone: +123 456 789',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ])));
  }

  void _searchLocations() async {
    final String postcode = _controller.text.trim();

    if (postcode.isEmpty) {
      print("error");
      return;
    }

    try {
      final userCoords = await geocodePostcode(
          postcode, 'AIzaSyD7_jakGIgJ7hGIq-OTiHpXoK_QYcb0m_I');
      List<Location> locations = await fetchLocations();

      print("Fetched ${locations.length} locations");

      double? latitude = userCoords['latitude'];
      double? longitude = userCoords['longitude'];

      if (latitude == null || longitude == null) {
        print("Geocoding failed or returned incomplete data.");
        return;
      }

      for (var location in locations) {
        location.distance = Location.calculateDistance(
          latitude,
          longitude,
          location.latitude,
          location.longitude,
        );
      }

      locations.sort((a, b) => a.distance.compareTo(b.distance));
      setState(() {
        //  _sortedLocations = [
        //    Location(
        //        name: "Test 1", latitude: 0.0, longitude: 0.0, distance: 1.0),
        //    Location(
        //        name: "Test 2", latitude: 0.0, longitude: 0.0, distance: 1.0),
        //  ];
        _sortedLocations = locations;
      });
    } catch (e) {
      print("Error Processing Search: $e");
    }
  }

  Future<Map<String, double>> geocodePostcode(
      String postcode, String apiKey) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(postcode)}&key=$apiKey');

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final location = data['results'][0]['geometry']['location'];

          return {
            'latitude': location['lat'],
            'longitude': location['lng'],
          };
        } else {
          print('Geocoding API returned status: ${data['status']}');
          throw Exception('Geocoding failed with status: ${data['status']}');
        }
      } else {
        print(
            'Failed to load data from geocoding API. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to load data from geocoding API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught while geocoding: $e');
      throw Exception('Exception caught while geocoding: $e');
    }
  }

  void fetchCoordinates() async {
    try {
      final apiKey = 'AIzaSyD7_jakGIgJ7hGIq-OTiHpXoK_QYcb0m_I';
      final postcode = 'SW1A 1AA';
      final coordinates = await geocodePostcode(postcode, apiKey);
      print('Coordinates: $coordinates');
    } catch (e) {
      print('Error: $e');
    }
  }
}
