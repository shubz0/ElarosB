import 'package:flutter/material.dart';
//import 'package:elaros/health_page.dart';
import 'package:elaros/features/home_page/home_page.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/features/my_health_page/models/c19_user_responses_model.dart'; // Import the user responses class

class C19Page4 extends StatefulWidget {
  final C19UserResponses userResponses; // Declare userResponses variable

  const C19Page4({super.key, required this.userResponses}); // Constructor

  @override
  C19Page4State createState() => C19Page4State();
}

class C19Page4State extends State<C19Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C19 Page 4'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall Health',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'How Good or Bad was Your Health in the Past 7 Days?',
                  ),
                  const SizedBox(height: 10.0),
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
                  const SizedBox(height: 20.0),
                  const Text(
                    'Pre-Covid',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
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
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text('Occupation'),
                  const SizedBox(height: 5.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.occupation = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your occupation',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Has Your COVID-19 Illness Affected Your Work?',
                  ),
                  _buildAffectedWorkCheckbox('No Change'),
                  _buildAffectedWorkCheckbox('On Reduced Working Hours'),
                  _buildAffectedWorkCheckbox('On Sickness Leave'),
                  _buildAffectedWorkCheckbox(
                      'Changes Made to Role/\nWorking Arrangements'),
                  _buildAffectedWorkCheckbox('Had to Retire/Change Job'),
                  _buildAffectedWorkCheckbox('Lost Job'),
                  const SizedBox(height: 10.0),
                  const Text('Any Other Comments/Concerns'),
                  const SizedBox(height: 5.0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        widget.userResponses.otherComments = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Additional Comments/Concerns',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
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
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) =>
                          false, // Remove all routes below the home page
                    );
                  },
                  child: const Text('Submit'),
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
