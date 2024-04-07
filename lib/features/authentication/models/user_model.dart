import 'package:cloud_firestore/cloud_firestore.dart';

//user model class

class UserModel {
  final String name;
  final String username;
  final String address;
  final String gender;
  final String bloodgroup;
  final String weight;

  UserModel({
    required this.name,
    required this.username,
    required this.address,
    required this.gender,
    required this.bloodgroup,
    required this.weight,
  });

//set of information being held

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        username: json['username'],
        address: json['address'],
        gender: json['gender'],
        bloodgroup: json['bloodgroup'],
        weight: json['weight'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'address': address,
      'gender': gender,
      'bloodgroup': bloodgroup,
      'weight': weight,
    };
  }
}

//saving collected user data to database

void addUserToFirestore(UserModel user, uid) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(user.toMap())
      .then((value) {})
      .catchError((error) {});
}

//updating database

void updateUserprofile(UserModel user, uid) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update(user.toMap())
      .then((value) {})
      .catchError((error) {});
}
