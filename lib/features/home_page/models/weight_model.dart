import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  final String weight;

  WeightModel({
    required this.weight,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
        weight: json['weight'],
      );

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
    };
  }
}

void updateWeightToFirebase(WeightModel user, uid) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update(user.toMap())
      .then((value) {})
      .catchError((error) {});
}
