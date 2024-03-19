import 'package:flutter/material.dart';
import 'package:elaros/health_page.dart';
import 'package:elaros/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/C19/c19_user_responses.dart'; // Import the user responses class

class C19Page4 extends StatefulWidget {
  final C19UserResponses userResponses; // Declare userResponses variable

  C19Page4({required this.userResponses}); // Constructor

  @override
  _C19Page4State createState() => _C19Page4State();
}

class _C19Page4State extends State<C19Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C19 Page 4'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Health',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'How good or bad was your health in the past 7 days?',
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: widget.userResponses.nowHealth,
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.nowHealth = value;
                      });
                    },
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: widget.userResponses.nowHealth.round().toString(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Pre-Covid',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: widget.userResponses.preCovidHealth,
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.preCovidHealth = value;
                      });
                    },
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label:
                        widget.userResponses.preCovidHealth.round().toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text('Occupation'),
                  SizedBox(height: 5.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.occupation = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your occupation',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Has your COVID-19 illness affected your work?',
                  ),
                  _buildAffectedWorkCheckbox('No change'),
                  _buildAffectedWorkCheckbox('On reduced working hours'),
                  _buildAffectedWorkCheckbox('On sickness leave'),
                  _buildAffectedWorkCheckbox(
                      'Changes made to role/working arrangements'),
                  _buildAffectedWorkCheckbox('Had to retire/change job'),
                  _buildAffectedWorkCheckbox('Lost job'),
                  SizedBox(height: 10.0),
                  Text('Any other comments/concerns'),
                  SizedBox(height: 5.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.otherComments = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter any other comments/concerns',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    // Save user responses before navigating to the next page
                    saveDataToFirestore();
                    // Navigate back to the home page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), 
                      (Route<dynamic> route) =>
                          false, // Remove all routes below the home page
                    );
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAffectedWorkCheckbox(String option) {
    return Row(
      children: [
        Checkbox(
          value: widget.userResponses.affectedWork.contains(option),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                widget.userResponses.affectedWork.add(option);
              } else {
                widget.userResponses.affectedWork.remove(option);
              }
            });
          },
        ),
        Text(option),
      ],
    );
  }

  // Method to save user responses to Firestore
  void saveDataToFirestore() {
    widget.userResponses
        .saveResponsesToFirestore(context); // Call the method to save responses
  }
}
