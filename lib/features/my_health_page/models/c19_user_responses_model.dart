import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class C19UserResponses {
  double breathlessnessAtRest = 0;
  double breathlessnessChangingPosition = 0;
  double breathlessnessOnDressing = 0;
  double breathlessnessWalkingUpStairs = 0;

  double throatSensitivity = 0;
  double changeOfVoice = 0;
  double alteredSmell = 0;
  double alteredTaste = 0;

  double fatigueLevels = 0;
  double chestPain = 0;
  double jointPain = 0;
  double musclePain = 0;
  double headache = 0;
  double abdominalPain = 0;

  double communicationDifficulty = 0;
  double walkingMovingAroundDifficulty = 0;
  double personalCareDifficulty = 0;
  double personalTasksDifficulty = 0;
  double widerActivitiesDifficulty = 0;
  double socializingDifficulty = 0;

  List<String> selectedSymptoms = [];

  double nowHealth = 5;
  double preCovidHealth = 5;

  String occupation = '';
  List<String> affectedWork = [];
  String otherComments = '';

  Future<void> saveResponsesToFirestore(BuildContext context) async {
    CollectionReference c19Collection =
        FirebaseFirestore.instance.collection('C19-responses');

    // Get the current user's email from Firebase Authentication
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Get the current date and time
    Timestamp now = Timestamp.now();

    // Add user responses to Firestore under a single document
    await c19Collection.add({
      'userEmail': userEmail,
      'dateTime': now, // Save date and time
      'breathlessnessAtRest': breathlessnessAtRest,
      'breathlessnessChangingPosition': breathlessnessChangingPosition,
      'breathlessnessOnDressing': breathlessnessOnDressing,
      'breathlessnessWalkingUpStairs': breathlessnessWalkingUpStairs,
      'throatSensitivity': throatSensitivity,
      'changeOfVoice': changeOfVoice,
      'alteredSmell': alteredSmell,
      'alteredTaste': alteredTaste,
      'fatigueLevels': fatigueLevels,
      'chestPain': chestPain,
      'jointPain': jointPain,
      'musclePain': musclePain,
      'headache': headache,
      'abdominalPain': abdominalPain,
      'communicationDifficulty': communicationDifficulty,
      'walkingMovingAroundDifficulty': walkingMovingAroundDifficulty,
      'personalCareDifficulty': personalCareDifficulty,
      'personalTasksDifficulty': personalTasksDifficulty,
      'widerActivitiesDifficulty': widerActivitiesDifficulty,
      'socializingDifficulty': socializingDifficulty,
      'selectedSymptoms': selectedSymptoms,
      'nowHealth': nowHealth,
      'preCovidHealth': preCovidHealth,
      'occupation': occupation,
      'affectedWork': affectedWork,
      'otherComments': otherComments,
    });

    // Display a message indicating successful data submission
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Assessment Saved Successfully'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
  }
}
