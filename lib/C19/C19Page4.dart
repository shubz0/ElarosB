import 'package:flutter/material.dart';
import 'package:elaros/health_page.dart';

class C19Page4 extends StatefulWidget {
  @override
  _C19Page4State createState() => _C19Page4State();
}

class _C19Page4State extends State<C19Page4> {
  double nowHealth = 5;
  double preCovidHealth = 5;

  String occupation = '';
  List<String> affectedWork = [];
  String otherComments = '';

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
                    value: nowHealth,
                    onChanged: (value) {
                      setState(() {
                        nowHealth = value;
                      });
                    },
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: nowHealth.round().toString(),
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
                    value: preCovidHealth,
                    onChanged: (value) {
                      setState(() {
                        preCovidHealth = value;
                      });
                    },
                    min: 0,
                    max: 10,
                    divisions: 10,
                    label: preCovidHealth.round().toString(),
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
                        occupation = value;
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
                        otherComments = value;
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHealthPage()),
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
          value: affectedWork.contains(option),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                affectedWork.add(option);
              } else {
                affectedWork.remove(option);
              }
            });
          },
        ),
        Text(option),
      ],
    );
  }
}
