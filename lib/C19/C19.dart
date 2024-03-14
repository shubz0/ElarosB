import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Page2.dart';

class C19Screen extends StatefulWidget {
  const C19Screen({super.key});

  @override
  _C19ScreenState createState() => _C19ScreenState();
}

class _C19ScreenState extends State<C19Screen> {
  double _breathlessnessAtRest = 0;
  double _breathlessnessChangingPosition = 0;
  double _breathlessnessOnDressing = 0;
  double _breathlessnessWalkingUpStairs = 0;

  double _throatSensitivity = 0;
  double _changeOfVoice = 0;
  double _alteredSmell = 0;
  double _alteredTaste = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Self Report'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionContainer(
              'Breathlessness',
              [
                _buildBreathlessnessQuestion(),
              ],
            ),
            _buildQuestionContainer(
              'Cough / throat sensitivity / voice change',
              [
                _buildThroatSensitivityQuestion(),
              ],
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: 400, 
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => C19Page2()),
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

  Widget _buildQuestionContainer(String title, List<Widget> questions) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: questions,
          ),
        ],
      ),
    );
  }

  Widget _buildSubQuestion(String title, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 3,
          divisions: 3,
          label: value.toString(),
        ),
      ],
    );
  }

  Widget _buildBreathlessnessQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubQuestion('At rest', _breathlessnessAtRest, (value) {
          setState(() {
            _breathlessnessAtRest = value;
          });
        }),
        _buildSubQuestion('Changing position', _breathlessnessChangingPosition, (value) {
          setState(() {
            _breathlessnessChangingPosition = value;
          });
        }),
        _buildSubQuestion('On dressing', _breathlessnessOnDressing, (value) {
          setState(() {
            _breathlessnessOnDressing = value;
          });
        }),
        _buildSubQuestion('Walking up stairs', _breathlessnessWalkingUpStairs, (value) {
          setState(() {
            _breathlessnessWalkingUpStairs = value;
          });
        }),
      ],
    );
  }

  Widget _buildThroatSensitivityQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubQuestion('Throat sensitivity', _throatSensitivity, (value) {
          setState(() {
            _throatSensitivity = value;
          });
        }),
        _buildSubQuestion('Change of voice', _changeOfVoice, (value) {
          setState(() {
            _changeOfVoice = value;
          });
        }),
        _buildSubQuestion('Altered smell', _alteredSmell, (value) {
          setState(() {
            _alteredSmell = value;
          });
        }),
        _buildSubQuestion('Altered taste', _alteredTaste, (value) {
          setState(() {
            _alteredTaste = value;
          });
        }),
      ],
    );
  }
}
