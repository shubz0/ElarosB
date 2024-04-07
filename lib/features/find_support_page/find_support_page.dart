import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/location_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FindSupportPage extends StatefulWidget {
  @override
  FindSupportPageState createState() => FindSupportPageState();
}

Future<List<Location>> fetchLocations() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Location> locations = [];
  try {
    QuerySnapshot snapshot = await firestore.collection('locations').get();
    for (var doc in snapshot.docs) {
      Location location =
          Location.fromFirestore(doc.data() as Map<String, dynamic>);
      locations.add(location);
    }
    return locations;
  } catch (e) {
    rethrow;
  }
}

class FindSupportPageState extends State<FindSupportPage> {
  final TextEditingController _controller = TextEditingController();
  List<Location> _sortedLocations = [];

  int? _selectedIndex;

  final postcodeRegExp = RegExp(
    //user input sanitisation
    r'^(([A-Z]{1,2}\d{0,2})|([A-Z]{1,2}\d{0,2}[A-Z]?)|([A-Z]{1,2}\d{0,2}[A-Z]?\s?\d{0,1}[A-Z]{0,2}))$',
    caseSensitive: false,
  );

  void showSuccessMessage() {
    //user feedback for UX
    const snackBar = SnackBar(
      content: Text('Success! Press a Clinic name for Directions'),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void noLocationsFoundMessage() {
    const snackBar = SnackBar(
      content: Text('No Locations Found'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmptyTextFieldMessage() {
    const snackBar = SnackBar(
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
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: const BoxDecoration(
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
              title: const Text(
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
          decoration: const BoxDecoration(
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      "We're here to Support you in All Ways Possible. We can Locate the nearest Clinic to you for an In Person Assessment. Start by entering your Postcode.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Enter Your Postcode",
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          helperText: _helperText,
                          helperStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty &&
                                RegExp(r'^\d').hasMatch(value)) {
                              _helperText = //helper text as snackbar for every instance of feedback = overwhelming UI = bad UX
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
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: _searchLocations,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(
                                  255, 11, 83, 81)), //search btn color
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff3C5C6C);
                            } //color of text on btn press
                            else {
                              return Colors.white;
                            } //default color of text in btn
                          })),
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 20), //padding below the search btn

                    Container(
                        constraints: const BoxConstraints(minHeight: 200),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.black)),
                        child: _sortedLocations.isEmpty
                            ? const Center(
                                child: Text(
                                  'Your nearest clinics will be displayed here',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                          const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          _selectedIndex = null;
                                        });
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      color: _selectedIndex == index
                                          ? Colors.grey[300]
                                          : Colors.transparent,
                                      child: ListTile(
                                        title: Text(location.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        subtitle: Text(
                                          "Distance: ${location.distance.toStringAsFixed(2)} miles",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),

                    const Divider(
                        height: 20,
                        thickness: 4,
                        color: Color.fromARGB(255, 11, 83, 81)),
                    Container(
                      //contact us container
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color.fromARGB(255, 11, 83, 81),
                            Color.fromARGB(255, 0, 169, 165)
                          ])),
                      child: const Column(
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

      double? latitude = userCoords['latitude'];
      double? longitude = userCoords['longitude'];

      if (latitude == null || longitude == null) {
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
      //
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
          throw Exception('Geocoding failed with status: ${data['status']}');
        }
      } else {
        throw Exception(
            'Failed to load data from geocoding API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception caught while geocoding: $e');
    }
  }

  Future<void> _launchMapsUrl(double lat, double lng) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');
    //user directed to google maps app(if installed/set as default maps app) or uses device browser
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
