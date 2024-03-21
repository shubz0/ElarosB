import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io';
import 'package:intl/intl.dart';

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

  Future<void> generateAndSendPdf(
      Map<String, dynamic> user, Map<String, dynamic> results) async {
    try {
      // Create a new PDF document
      final pdf = pdfWidgets.Document();

      // Define a map that maps variable names to display names
      final Map<String, String> displayNameMap = {
        'breathlessnessAtRest': 'Breathlessness at Rest',
        'breathlessnessChangingPosition': 'Breathlessness Changing Position',
        'breathlessnessOnDressing': 'Breathlessness on Dressing',
        'breathlessnessWalkingUpStairs': 'Breathlessness Walking Up Stairs',
        'throatSensitivity': 'Throat Sensitivity',
        'changeOfVoice': 'Change of Voice',
        'alteredSmell': 'Altered Smell',
        'alteredTaste': 'Altered Taste',
        'fatigueLevels': 'Fatigue Levels',
        'chestPain': 'Chest Pain',
        'jointPain': 'Joint Pain',
        'musclePain': 'Muscle Pain',
        'headache': 'Headache',
        'abdominalPain': 'Abdominal Pain',
        'communicationDifficulty': 'Communication Difficulty',
        'walkingMovingAroundDifficulty': 'Walking/Moving Around Difficulty',
        'personalCareDifficulty': 'Personal Care Difficulty',
        'personalTasksDifficulty': 'Personal Tasks Difficulty',
        'widerActivitiesDifficulty': 'Wider Activities Difficulty',
        'socializingDifficulty': 'Socializing Difficulty',
        'selectedSymptoms': 'Selected Symptoms',
        'nowHealth': 'Now Health',
        'preCovidHealth': 'Pre-COVID Health',
        'otherComments': 'Other Comments',
      };

// Define the order of the test results as per the UI
      final List<String> testResultOrder = [
        'breathlessnessAtRest',
        'breathlessnessChangingPosition',
        'breathlessnessOnDressing',
        'breathlessnessWalkingUpStairs',
        'throatSensitivity',
        'changeOfVoice',
        'alteredSmell',
        'alteredTaste',
        'fatigueLevels',
        'chestPain',
        'jointPain',
        'musclePain',
        'headache',
        'abdominalPain',
        'communicationDifficulty',
        'walkingMovingAroundDifficulty',
        'personalCareDifficulty',
        'personalTasksDifficulty',
        'widerActivitiesDifficulty',
        'socializingDifficulty',
        'selectedSymptoms',
        'nowHealth',
        'preCovidHealth',
        'otherComments',
      ];

// Add user information to the PDF
      pdf.addPage(
        pdfWidgets.Page(
          build: (context) {
            // Convert the timestamp to a DateTime object
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                results['dateTime'].seconds * 1000);

            // Format the DateTime object into a readable string
            String formattedDateTime =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

            return pdfWidgets.Column(
              crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
              children: [
                pdfWidgets.Text('User Information',
                    style: pdfWidgets.TextStyle(
                        fontWeight: pdfWidgets.FontWeight.bold)),
                pdfWidgets.Text('Name: ${user['name'] ?? 'N/A'}'),
                pdfWidgets.Text('Email: ${results['userEmail'] ?? 'N/A'}'),
                pdfWidgets.Text(
                    'Occupation: ${results['occupation'] ?? 'N/A'}'),
                pdfWidgets.Divider(), // Add a line separator
                pdfWidgets.SizedBox(
                    height:
                        20), // Add some space between user information and test results
                pdfWidgets.Text('Test Results',
                    style: pdfWidgets.TextStyle(
                        fontWeight: pdfWidgets.FontWeight.bold)),
                // Add each test result in the correct order
                for (String key in testResultOrder)
                  if (results.containsKey(key))
                    pdfWidgets.Row(
                      children: [
                        pdfWidgets.Expanded(
                          flex: 3,
                          child: pdfWidgets.Text(
                            displayNameMap[key] ?? key,
                            // Use display name if available, otherwise use variable name
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold),
                          ),
                        ),
                        pdfWidgets.Text(
                          '-  ',
                          style: pdfWidgets.TextStyle(
                              fontWeight: pdfWidgets.FontWeight.bold),
                        ),
                        pdfWidgets.Expanded(
                          flex: 2,
                          child: pdfWidgets.Text(
                            key == 'dateTime'
                                ? formattedDateTime
                                : (results[key] != null
                                    ? results[key].toString()
                                    : 'N/A'),
                            textAlign: pdfWidgets.TextAlign.left,
                          ),
                        ),
                      ],
                    ),
              ],
            );
          },
        ),
      );

      // Generate PDF bytes
      final pdfBytes = await pdf.save();

      // Save PDF bytes to a temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/test_results.pdf';
      final tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(pdfBytes);

      // Send email with the PDF attached
      final smtpServer = SmtpServer('smtp.office365.com',
          username: 'Elarosteamb@outlook.com',
          password: 'BlueMonster786',
          port: 587, // Port for TLS (Transport Layer Security) encryption
          ssl: false, // Use TLS instead of SSL (Secure Sockets Layer)
          allowInsecure: false,
          ignoreBadCertificate: true);

      final message = Message()
        ..from = Address('Elarosteamb@outlook.com', 'Elaros') // Your Outlook email address and optional display name
        ..recipients
            .add(results['userEmail'] ?? '') // Recipient's email address
        ..subject = 'Test Results'
        ..text = 'Please find the attached test results PDF.'
        ..attachments.add(FileAttachment(tempFile));

      // Send the email
      await send(message, smtpServer);

      print('Email sent successfully!');
    } catch (e, stackTrace) {
      print('Error sending email: $e');
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
                    Result('Selected Symptoms',
                        results['selectedSymptoms']?.join(', ') ?? 'N/A'),
                    Result('Now Health', results['nowHealth']),
                    Result('Pre-COVID Health', results['preCovidHealth']),
                    Result('Other Comments', results['otherComments']),
                    SizedBox(height: 16),
                    // Export button
                    ElevatedButton(
                      onPressed: () async {
                        await generateAndSendPdf(user, results);
                        // Show SnackBar when the email is sent successfully
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email sent!'),
                          ),
                        );
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
          flex: 3,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '-',
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

class Result extends StatelessWidget {
  final String label;
  final dynamic value;

  const Result(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '-  ',
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
