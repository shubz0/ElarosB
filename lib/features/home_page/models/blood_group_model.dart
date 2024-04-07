import 'package:cloud_firestore/cloud_firestore.dart';

class BloodGroupModel {
  final String bloodgroup;

  BloodGroupModel({
    required this.bloodgroup,
  });

  factory BloodGroupModel.fromJson(Map<String, dynamic> json) =>
      BloodGroupModel(
        bloodgroup: json['bloodgroup'],
      );

  Map<String, dynamic> toMap() {
    return {
      'bloodgroup': bloodgroup,
    };
  }
}

void updateBloodgroupFirebase(BloodGroupModel user, uid) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update(user.toMap())
      .then((value) {})
      .catchError((error) {});
}
