import 'package:flutter/material.dart';
import 'package:elaros/features/my_health_page/screens/c19_export.dart';
import 'package:elaros/features/my_health_page/screens/c19_test_results.dart';
import 'package:elaros/features/my_health_page/screens/c19_test/c19_test_page_1.dart';
import 'package:elaros/styles/colour.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(double.infinity, 80),
  backgroundColor: const Color.fromARGB(
      255, 0, 169, 165), // Adjusted color to match the teal theme
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);

class MyHealthPage extends StatelessWidget {
  const MyHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Health',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 11, 83, 81),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 11, 83, 81),
                  Color.fromARGB(255, 0, 169, 165),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Assessment',
                  style: TextStyle(
                    color: white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Today is a good day to check up on yourself!',
                  style: TextStyle(
                    color: white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const C19Screen()));
                    },
                    icon: Icon(
                      Icons.local_hospital,
                      color: white,
                    ),
                    label: Text(
                      'C19 Test',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const C19TestResults()));
                    },
                    icon: Icon(
                      Icons.insert_chart_outlined,
                      color: white,
                    ),
                    label: Text(
                      'Test Results',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => C19Export()));
                    },
                    icon: Icon(
                      Icons.print,
                      color: white,
                    ),
                    label: Text(
                      'Export',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
