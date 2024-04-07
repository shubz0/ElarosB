import 'dart:math';

//location data class

class Location {
  final String name;
  final double latitude;
  final double longitude;
  double distance = 0.0;

  Location(
      {required this.name,
      required this.latitude,
      required this.longitude,
      this.distance = 0.0});

  factory Location.fromFirestore(Map<String, dynamic> firestoreData) {
    return Location(
      name: firestoreData['name'],
      latitude:
          firestoreData['latitude'], //set locations which are acting as clinics
      longitude: firestoreData['longitude'],
    );
  }

  static double calculateDistance(
      //haversine formula used to calculate distance from user input postcode to set locations in db
      double lat1,
      double lon1,
      double lat2,
      double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
