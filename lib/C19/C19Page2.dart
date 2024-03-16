import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Page3.dart';

class C19Page2 extends StatefulWidget {
  @override
  _C19Page2State createState() => _C19Page2State();
}

class _C19Page2State extends State<C19Page2> {
  double _fatigueLevels = 0;
  double _chestPain = 0;
  double _jointPain = 0;
  double _musclePain = 0;
  double _headache = 0;
  double _abdominalPain = 0;

  double _communicationDifficulty = 0;
  double _walkingMovingAroundDifficulty = 0;
  double _personalCareDifficulty = 0;
  double _personalTasksDifficulty = 0;
  double _widerActivitiesDifficulty = 0;
  double _socializingDifficulty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Self Report - Page 2'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionContainer(
              'Pain / discomfort',
              [
                _buildPainDiscomfortQuestion(),
              ],
            ),
            _buildQuestionContainer(
              'Functional Ability',
              [
                _buildFunctionalAbilityQuestion(),
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
                      MaterialPageRoute(builder: (context) => C19Page3()),
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

  Widget _buildPainDiscomfortQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubQuestion('Fatigue levels in your usual activities', _fatigueLevels, (value) {
          setState(() {
            _fatigueLevels = value;
          });
        }),
        _buildSubQuestion('Chest pain', _chestPain, (value) {
          setState(() {
            _chestPain = value;
          });
        }),
        _buildSubQuestion('Joint pain', _jointPain, (value) {
          setState(() {
            _jointPain = value;
          });
        }),
        _buildSubQuestion('Muscle pain', _musclePain, (value) {
          setState(() {
            _musclePain = value;
          });
        }),
        _buildSubQuestion('Headache', _headache, (value) {
          setState(() {
            _headache = value;
          });
        }),
        _buildSubQuestion('Abdominal pain', _abdominalPain, (value) {
          setState(() {
            _abdominalPain = value;
          });
        }),
      ],
    );
  }

  Widget _buildFunctionalAbilityQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       _buildSubQuestion('Difficulty with communication', _communicationDifficulty, (value) {
          setState(() {
            _communicationDifficulty = value;
          });
        }),
        _buildSubQuestion('Walking or moving around', _walkingMovingAroundDifficulty, (value) {
          setState(() {
            _walkingMovingAroundDifficulty = value;
          });
        }),
        _buildSubQuestion('Personal Care', _personalCareDifficulty, (value) {
          setState(() {
            _personalCareDifficulty = value;
          });
        }),
        _buildSubQuestion('Difficulties with personal tasks', _personalTasksDifficulty, (value) {
          setState(() {
            _personalTasksDifficulty = value;
          });
        }),
        _buildSubQuestion('Difficulty doing wider activities', _widerActivitiesDifficulty, (value) {
          setState(() {
            _widerActivitiesDifficulty = value;
          });
        }),
        _buildSubQuestion('Problems with socialising/interacting with friends', _socializingDifficulty, (value) {
          setState(() {
            _socializingDifficulty = value;
          });
        }),
      ],
    );
  }
}
