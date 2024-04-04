import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/LocationModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

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

  int? _selectedIndex;

  final postcodeRegExp = RegExp(
    r'^(([A-Z]{1,2}\d{0,2})|([A-Z]{1,2}\d{0,2}[A-Z]?)|([A-Z]{1,2}\d{0,2}[A-Z]?\s?\d{0,1}[A-Z]{0,2}))$',
    caseSensitive: false,
  );

  void showSuccessMessage() {
    final snackBar = SnackBar(
      content: Text('Success! Press a Clinic name for Directions'),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void noLocationsFoundMessage() {
    final snackBar = SnackBar(
      content: Text('No Locations Found'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmptyTextFieldMessage() {
    final snackBar = SnackBar(
      content: Text('Enter a Valid Postcode'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _helperText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(
                    255, 0, 169, 165), //background color of the whole page
                Colors.white,
              ],
            ),
          ),
          child: Column(children: [
            Padding(
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
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Enter Your Postcode",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          helperText: _helperText,
                          helperStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty &&
                                RegExp(r'^\d').hasMatch(value)) {
                              _helperText =
                                  'Postcode Cannot Start with a Number';
                            } else if (!postcodeRegExp.hasMatch(value) &&
                                value.isNotEmpty) {
                              _helperText =
                                  'Invalid Format! Must be AA12 3AA or AA123AA';
                            } else {
                              _helperText = '';
                            }
                          });
                        }),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _searchLocations,
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(
                                  255, 11, 83, 81)), //search btn color
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Color(
                                  0xff3C5C6C); //color of text on btn press
                            return Colors.white; //default color of text in btn
                          })),
                    ),
                    SizedBox(height: 20), //padding below the search btn

                    Container(
                        constraints: BoxConstraints(minHeight: 200),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.black)),
                        child: _sortedLocations.isEmpty
                            ? Center(
                                child: Text(
                                  'Your nearest clinics will be displayed here',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _sortedLocations.length,
                                itemBuilder: (context, index) {
                                  final location = _sortedLocations[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                        _launchMapsUrl(location.latitude,
                                            location.longitude);
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        setState(() {
                                          _selectedIndex = null;
                                        });
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      color: _selectedIndex == index
                                          ? Colors.grey[300]
                                          : Colors.transparent,
                                      child: ListTile(
                                        title: Text(location.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        subtitle: Text(
                                          "Distance: ${location.distance.toStringAsFixed(2)} miles",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),

                    Divider(
                        height: 20,
                        thickness: 4,
                        color: Color.fromARGB(255, 11, 83, 81)),
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
                  ]),
            )
          ]),
        )));
  }

  void _searchLocations() async {
    final String postcode = _controller.text.trim();

    if (postcode.isEmpty) {
      showEmptyTextFieldMessage();
      return;
    }

    try {
      final userCoords = await geocodePostcode(
          postcode, 'AIzaSyD7_jakGIgJ7hGIq-OTiHpXoK_QYcb0m_I');
      final List<Location> locations = await fetchLocations();

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
        _sortedLocations = locations;
      });

      if (locations.isNotEmpty) {
        showSuccessMessage();
      } else {
        noLocationsFoundMessage();
        return;
      }
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

  Future<void> _launchMapsUrl(double lat, double lng) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }
}
