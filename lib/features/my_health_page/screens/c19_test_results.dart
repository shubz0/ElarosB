import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class C19TestResults extends StatefulWidget {
  const C19TestResults({super.key});
  @override
  C19TestResultsState createState() => C19TestResultsState();
}

class C19TestResultsState extends State<C19TestResults> {
  late Future<List<Map<String, dynamic>>> testResults;

  @override
  void initState() {
    super.initState();
    testResults = fetchTestResults();
  }

  Future<List<Map<String, dynamic>>> fetchTestResults() async {
    // Trigger query to Firestore to create the required index
    await FirebaseFirestore.instance
        .collection('C19-responses')
        .orderBy('dateTime')
        .get(const GetOptions(source: Source.serverAndCache));

    // Get the current user's email from Firebase Authentication
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Query the test results from Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('C19-responses')
        .where('userEmail', isEqualTo: userEmail)
        .orderBy('dateTime', descending: true)
        .get();

    // Extract the data from the query snapshot
    List<Map<String, dynamic>> results = [];
    querySnapshot.docs.forEach((doc) {
      results.add(doc.data() as Map<String, dynamic>);
    });

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C19 Test Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: testResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Map<String, dynamic>> results = snapshot.data ?? [];
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ExpansionTile(
                      title: Text('Test ${index + 1}'),
                      subtitle: Text(
                        'Date: ${results[index]['dateTime'].toDate().toString()}',
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Breathlessness at Rest: ${results[index]['breathlessnessAtRest']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Breathlessness Changing Position: ${results[index]['breathlessnessChangingPosition']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Breathlessness on Dressing: ${results[index]['breathlessnessOnDressing']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Breathlessness Walking Up Stairs: ${results[index]['breathlessnessWalkingUpStairs']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Throat Sensitivity: ${results[index]['throatSensitivity']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Change of Voice: ${results[index]['changeOfVoice']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Altered Smell: ${results[index]['alteredSmell']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Altered Taste: ${results[index]['alteredTaste']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Fatigue Levels: ${results[index]['fatigueLevels']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Chest Pain: ${results[index]['chestPain']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Joint Pain: ${results[index]['jointPain']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Muscle Pain: ${results[index]['musclePain']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Headache: ${results[index]['headache']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Abdominal Pain: ${results[index]['abdominalPain']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Communication Difficulty: ${results[index]['communicationDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Walking/Moving Around Difficulty: ${results[index]['walkingMovingAroundDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Personal Care Difficulty: ${results[index]['personalCareDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Personal Tasks Difficulty: ${results[index]['personalTasksDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Wider Activities Difficulty: ${results[index]['widerActivitiesDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Socializing Difficulty: ${results[index]['socializingDifficulty']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Selected Symptoms: ${results[index]['selectedSymptoms']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Now Health: ${results[index]['nowHealth']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Pre-COVID Health: ${results[index]['preCovidHealth']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Occupation: ${results[index]['occupation']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Affected Work: ${results[index]['affectedWork']}',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Other Comments: ${results[index]['otherComments']}',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
