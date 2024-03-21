import 'package:flutter/material.dart';
import 'package:elaros/C19/C19Export.dart';
import 'package:elaros/C19/C19TestResults.dart';
import 'package:elaros/C19/C19.dart';

Color blackPrimary = Color(0xff212131);
Color black = Color(0xff09050D);
Color grey = Color.fromARGB(255, 183, 183, 185);
Color orange = Color(0xffFF815E);
Color white = Color(0xffffffff);
Color purple = Color(0xff613FE5);
Color softPurple = Color(0xffD0C3FF);

Color darkBlue = Color.fromARGB(255, 45, 50, 80);
Color darkishBlue = Color.fromARGB(255, 66, 71, 105);
Color blue = Color.fromARGB(255, 112, 119, 161);
Color lightorange = Color.fromARGB(255, 246, 178, 122);

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(double.infinity, 80),
  backgroundColor: Color.fromARGB(255, 0, 169, 165), // Adjusted color to match the teal theme
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
);

class MyHealthPage extends StatelessWidget {
  const MyHealthPage({Key? key}) : super(key: key);

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
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
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
                SizedBox(height: 10.0),
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
          SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => C19Screen()));
                    },
                    icon: Icon(Icons.local_hospital, color: white,),
                    label: Text(
                      'C19 Test',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => C19TestResults()));
                    },
                    icon: Icon(Icons.insert_chart_outlined, color: white,),
                    label: Text(
                      'Test Results',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton.icon(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => C19Export()));
                    },
                    icon: Icon(Icons.print, color: white,),
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
