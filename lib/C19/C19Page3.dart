import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Page4.dart';

class C19Page3 extends StatefulWidget {
  @override
  _C19Page3State createState() => _C19Page3State();
}

class _C19Page3State extends State<C19Page3> {
  List<String> selectedSymptoms = [];

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
                  _buildSymptomCheckbox('Fever'),
                  _buildSymptomCheckbox('Skin rash/ discolouration of skin'),
                  _buildSymptomCheckbox('New allergy such as medication, food etc'),
                  _buildSymptomCheckbox('Hair loss'),
                  _buildSymptomCheckbox('Skin sensation (numbness/tingling/itching/nerve pain)'),
                  _buildSymptomCheckbox('Dry eyes/ redness of eyes'),
                  _buildSymptomCheckbox('Swelling of feet/ swelling of hands'),
                  _buildSymptomCheckbox('Easy bruising/ bleeding'),
                  _buildSymptomCheckbox('Visual changes'),
                  _buildSymptomCheckbox('Difficulty swallowing solids'),
                  _buildSymptomCheckbox('Difficulty swallowing liquids'),
                  _buildSymptomCheckbox('Balance problems or falls'),
                  _buildSymptomCheckbox('Weakness/movement problems/coordination problems'),
                  _buildSymptomCheckbox('Tinnitus'),
                  _buildSymptomCheckbox('Nausea'),
                  _buildSymptomCheckbox('Dry mouth/mouth ulcers'),
                  _buildSymptomCheckbox('Acid Reflux/heartburn'),
                  _buildSymptomCheckbox('Change in appetite'),
                  _buildSymptomCheckbox('Unintentional weight loss'),
                  _buildSymptomCheckbox('Unintentional weight gain'),
                  _buildSymptomCheckbox('Bladder frequency, urgency or incontinence'),
                  _buildSymptomCheckbox('Constipation, diarrhoea or bowel incontinence'),
                  _buildSymptomCheckbox('Change in menstrual cycles or flow'),
                  _buildSymptomCheckbox('Waking up at night gasping for air (also called sleep apnea)'),
                  _buildSymptomCheckbox('Thoughts about harming yourself'),
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
                      MaterialPageRoute(builder: (context) => C19Page4()),
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

  Widget _buildSymptomCheckbox(String symptom) {
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
}
