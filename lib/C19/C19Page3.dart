import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Page4.dart';
import 'package:elaros/C19/c19_user_responses.dart'; // Import the user responses class

class C19Page3 extends StatefulWidget {
  final C19UserResponses userResponses; // Declare userResponses variable

  C19Page3({required this.userResponses}); // Constructor

  @override
  _C19Page3State createState() => _C19Page3State();
}

class _C19Page3State extends State<C19Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Self Report - Page 3'),
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
                    'Other Symptoms',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _buildSymptomCheckbox('Fever', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Skin rash/ discolouration of skin', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('New allergy such as medication, food etc', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Hair loss', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Skin sensation (numbness/tingling/itching/nerve pain)', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Dry eyes/ redness of eyes', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Swelling of feet/ swelling of hands', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Easy bruising/ bleeding', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Visual changes', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Difficulty swallowing solids', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Difficulty swallowing liquids', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Balance problems or falls', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Weakness/movement problems/coordination problems', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Tinnitus', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Nausea', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Dry mouth/mouth ulcers', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Acid Reflux/heartburn', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Change in appetite', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Unintentional weight loss', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Unintentional weight gain', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Bladder frequency, urgency or incontinence', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Constipation, diarrhoea or bowel incontinence', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Change in menstrual cycles or flow', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Waking up at night gasping for air (also called sleep apnea)', widget.userResponses.selectedSymptoms),
                  _buildSymptomCheckbox('Thoughts about harming yourself', widget.userResponses.selectedSymptoms),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => C19Page4(userResponses: widget.userResponses)),
                    );
                  },
                  child: Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCheckbox(String symptom, List<String> selectedSymptoms) {
    return Row(
      children: [
        Checkbox(
          value: selectedSymptoms.contains(symptom),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                selectedSymptoms.add(symptom);
              } else {
                selectedSymptoms.remove(symptom);
              }
            });
          },
        ),
        Text(symptom),
      ],
    );
  }

  // Method to save user symptoms to Firestore via the user responses object
  void saveSymptomsToUser() {
    widget.userResponses.selectedSymptoms = widget.userResponses.selectedSymptoms; // Copy selected symptoms
    widget.userResponses.saveResponsesToFirestore(context); // Save responses
  }
}
