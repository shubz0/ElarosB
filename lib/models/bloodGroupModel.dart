import 'package:cloud_firestore/cloud_firestore.dart';

class bloodGroupModel {
  final String bloodgroup;

  bloodGroupModel({
    required this.bloodgroup,
  });

  factory bloodGroupModel.fromJson(Map<String, dynamic> json) => bloodGroupModel(
    bloodgroup: json['bloodgroup'],
  );

  Map<String, dynamic> toMap() {
    return {
      'bloodgroup': bloodgroup,
    };
  }
}

void updateBloodgroupFirebase(bloodGroupModel user, uid) {
  FirebaseFirestore.instance
      .collection('users').doc(uid)
      .update(user.toMap())
      .then((value) {
    print('User added to Firestore!');
  }).catchError((error) {
    print('Failed to add user to Firestore: $error');
  });
}