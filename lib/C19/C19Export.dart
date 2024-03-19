import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class C19Export extends StatefulWidget {
  @override
  _C19ExportState createState() => _C19ExportState();
}

class _C19ExportState extends State<C19Export> {
  late Future<Map<String, dynamic>> testResults;
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    testResults = fetchTestResults();
    userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchTestResults() async {
    // Get the current user's email from Firebase Authentication
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Query the most recent test results from Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('C19-responses')
        .where('userEmail', isEqualTo: userEmail)
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get();

    // Extract the data from the query snapshot
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      throw Exception('No test results found for the current user.');
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    // Get the current user's UID from Firebase Authentication
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Query the user's data from the users collection in Firestore
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Extract the data from the document snapshot
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('User data not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C19 Export'),
      ),
      body: FutureBuilder(
        future: Future.wait([testResults, userData]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Once test results and user data are fetched, display them in the UI
              Map<String, dynamic> results = snapshot.data?[0] ?? {};
              Map<String, dynamic> user = snapshot.data?[1] ?? {};

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display user's information
                    Text('User Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Name: ${user['name'] ?? 'N/A'}'),
                    Text('Email: ${results['userEmail'] ?? 'N/A'}'),
                    Text('Occupation: ${results['occupation'] ?? 'N/A'}'),
                    Divider(),
                    // Display test results
                    Text('Test Results',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    // Display each test result
                    _buildTestResult('Breathlessness at Rest',
                        results['breathlessnessAtRest']),
                    _buildTestResult('Breathlessness Changing Position',
                        results['breathlessnessChangingPosition']),
                    _buildTestResult('Breathlessness on Dressing',
                        results['breathlessnessOnDressing']),
                    _buildTestResult('Breathlessness Walking Up Stairs',
                        results['breathlessnessWalkingUpStairs']),
                    _buildTestResult(
                        'Throat Sensitivity', results['throatSensitivity']),
                    _buildTestResult(
                        'Change of Voice', results['changeOfVoice']),
                    _buildTestResult('Altered Smell', results['alteredSmell']),
                    _buildTestResult('Altered Taste', results['alteredTaste']),
                    _buildTestResult(
                        'Fatigue Levels', results['fatigueLevels']),
                    _buildTestResult('Chest Pain', results['chestPain']),
                    _buildTestResult('Joint Pain', results['jointPain']),
                    _buildTestResult('Muscle Pain', results['musclePain']),
                    _buildTestResult('Headache', results['headache']),
                    _buildTestResult(
                        'Abdominal Pain', results['abdominalPain']),
                    _buildTestResult('Communication Difficulty',
                        results['communicationDifficulty']),
                    _buildTestResult('Walking/Moving Around Difficulty',
                        results['walkingMovingAroundDifficulty']),
                    _buildTestResult('Personal Care Difficulty',
                        results['personalCareDifficulty']),
                    _buildTestResult('Personal Tasks Difficulty',
                        results['personalTasksDifficulty']),
                    _buildTestResult('Wider Activities Difficulty',
                        results['widerActivitiesDifficulty']),
                    _buildTestResult('Socializing Difficulty',
                        results['socializingDifficulty']),
                    _buildTestResult('Selected Symptoms',
                        results['selectedSymptoms']?.join(', ') ?? 'N/A'),
                    _buildTestResult('Now Health', results['nowHealth']),
                    _buildTestResult(
                        'Pre-COVID Health', results['preCovidHealth']),
                    _buildTestResult(
                        'Other Comments', results['otherComments']),
                    SizedBox(height: 16),
                    // Export button
                    ElevatedButton(
                      onPressed: () {
                        // Add code to export PDF here
                      },
                      child: Text('Export PDF'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildTestResult(String label, dynamic value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '     -     ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value != null ? value.toString() : 'N/A',
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
