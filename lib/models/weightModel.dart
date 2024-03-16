import 'package:cloud_firestore/cloud_firestore.dart';

class weightModel {
  final String weight;

  weightModel({
    required this.weight,
  });

  factory weightModel.fromJson(Map<String, dynamic> json) => weightModel(
    weight: json['weight'],
  );

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
    };
  }
}

void updateWeightToFirebase(weightModel user, uid) {
  FirebaseFirestore.instance
      .collection('users').doc(uid)
      .update(user.toMap())
      .then((value) {
    print('User added to Firestore!');
  }).catchError((error) {
    print('Failed to add user to Firestore: $error');
  });
}