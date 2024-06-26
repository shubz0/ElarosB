import 'package:flutter/material.dart';
import 'package:elaros/features/my_health_page/screens/c19_test/c19_test_page_2.dart';
import 'package:elaros/features/my_health_page/models/c19_user_responses_model.dart';

class C19Screen extends StatefulWidget {
  const C19Screen({super.key});

  @override
  C19ScreenState createState() => C19ScreenState();
}

class C19ScreenState extends State<C19Screen> {
  C19UserResponses userResponses = C19UserResponses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Self Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              'Cough / Throat Sensitivity / Voice Change',
              [
                _buildThroatSensitivityQuestion(),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next page and pass userResponses object
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              C19Page2(userResponses: userResponses)),
                    );
                  },
                  child: const Text('Next'),
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
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: questions,
          ),
        ],
      ),
    );
  }

  Widget _buildSubQuestion(
      String title, double value, Function(double) onChanged) {
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
        _buildSubQuestion('At Rest', userResponses.breathlessnessAtRest,
            (value) {
          setState(() {
            userResponses.breathlessnessAtRest = value;
          });
        }),
        _buildSubQuestion(
            'Changing Position', userResponses.breathlessnessChangingPosition,
            (value) {
          setState(() {
            userResponses.breathlessnessChangingPosition = value;
          });
        }),
        _buildSubQuestion('On Dressing', userResponses.breathlessnessOnDressing,
            (value) {
          setState(() {
            userResponses.breathlessnessOnDressing = value;
          });
        }),
        _buildSubQuestion('Walking up the Stairs',
            userResponses.breathlessnessWalkingUpStairs, (value) {
          setState(() {
            userResponses.breathlessnessWalkingUpStairs = value;
          });
        }),
      ],
    );
  }

  Widget _buildThroatSensitivityQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubQuestion('Throat Sensitivity', userResponses.throatSensitivity,
            (value) {
          setState(() {
            userResponses.throatSensitivity = value;
          });
        }),
        _buildSubQuestion('Change of Voice', userResponses.changeOfVoice,
            (value) {
          setState(() {
            userResponses.changeOfVoice = value;
          });
        }),
        _buildSubQuestion('Altered Smell', userResponses.alteredSmell, (value) {
          setState(() {
            userResponses.alteredSmell = value;
          });
        }),
        _buildSubQuestion('Altered Taste', userResponses.alteredTaste, (value) {
          setState(() {
            userResponses.alteredTaste = value;
          });
        }),
      ],
    );
  }
}
