import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String username;
  final String address;
  final String gender;
<<<<<<< HEAD
  final String bloodgroup;
  final String weight;
=======
>>>>>>> origin/main

  UserModel({
    required this.name,
    required this.username,
    required this.address,
    required this.gender,
<<<<<<< HEAD
    required this.bloodgroup,
    required this.weight,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'],
    username: json['username'],
    address: json['address'],
    gender: json['gender'],
    bloodgroup: json['bloodgroup'],
    weight: json['weight'],
  );
=======
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        username: json['username'],
        address: json['address'],
        gender: json['gender'],
      );
>>>>>>> origin/main

  Map<String, dynamic> toMap() {
    return {
      'name': name,
<<<<<<< HEAD
      'username' : username,
      'address': address,
      'gender': gender,
      'bloodgroup': bloodgroup,
      'weight': weight,
=======
      'username': username,
      'address': address,
      'gender': gender,
>>>>>>> origin/main
    };
  }
}

void addUserToFirestore(UserModel user, uid) {
  FirebaseFirestore.instance
<<<<<<< HEAD
      .collection('users').doc(uid)
=======
      .collection('users')
      .doc(uid)
>>>>>>> origin/main
      .set(user.toMap())
      .then((value) {
    print('User added to Firestore!');
  }).catchError((error) {
    print('Failed to add user to Firestore: $error');
  });
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
