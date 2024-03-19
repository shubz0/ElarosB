import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Page3.dart';
import 'package:elaros/C19/c19_user_responses.dart'; // Import the user responses class

class C19Page2 extends StatefulWidget {
  final C19UserResponses userResponses; // Declare userResponses variable

  C19Page2({required this.userResponses}); // Constructor

  @override
  _C19Page2State createState() => _C19Page2State();
}

class _C19Page2State extends State<C19Page2> {
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
                      MaterialPageRoute(builder: (context) => C19Page3(userResponses: widget.userResponses)),
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
        _buildSubQuestion('Fatigue levels in your usual activities', widget.userResponses.fatigueLevels, (value) {
          setState(() {
            widget.userResponses.fatigueLevels = value;
          });
        }),
        _buildSubQuestion('Chest pain', widget.userResponses.chestPain, (value) {
          setState(() {
            widget.userResponses.chestPain = value;
          });
        }),
        _buildSubQuestion('Joint pain', widget.userResponses.jointPain, (value) {
          setState(() {
            widget.userResponses.jointPain = value;
          });
        }),
        _buildSubQuestion('Muscle pain', widget.userResponses.musclePain, (value) {
          setState(() {
            widget.userResponses.musclePain = value;
          });
        }),
        _buildSubQuestion('Headache', widget.userResponses.headache, (value) {
          setState(() {
            widget.userResponses.headache = value;
          });
        }),
        _buildSubQuestion('Abdominal pain', widget.userResponses.abdominalPain, (value) {
          setState(() {
            widget.userResponses.abdominalPain = value;
          });
        }),
      ],
    );
  }

  Widget _buildFunctionalAbilityQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubQuestion('Difficulty with communication', widget.userResponses.communicationDifficulty, (value) {
          setState(() {
            widget.userResponses.communicationDifficulty = value;
          });
        }),
        _buildSubQuestion('Walking or moving around', widget.userResponses.walkingMovingAroundDifficulty, (value) {
          setState(() {
            widget.userResponses.walkingMovingAroundDifficulty = value;
          });
        }),
        _buildSubQuestion('Personal Care', widget.userResponses.personalCareDifficulty, (value) {
          setState(() {
            widget.userResponses.personalCareDifficulty = value;
          });
        }),
        _buildSubQuestion('Difficulties with personal tasks', widget.userResponses.personalTasksDifficulty, (value) {
          setState(() {
            widget.userResponses.personalTasksDifficulty = value;
          });
        }),
        _buildSubQuestion('Difficulty doing wider activities', widget.userResponses.widerActivitiesDifficulty, (value) {
          setState(() {
            widget.userResponses.widerActivitiesDifficulty = value;
          });
        }),
        _buildSubQuestion('Problems with socialising/interacting with friends', widget.userResponses.socializingDifficulty, (value) {
          setState(() {
            widget.userResponses.socializingDifficulty = value;
          });
        }),
      ],
    );
  }

  // Method to save user responses to Firestore via the user responses object
  void saveResponsesToUser() {
    widget.userResponses.saveResponsesToFirestore(context);
  }
}
