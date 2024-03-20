import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:elaros/styles/colour.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int userCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserCount();
  }

  Future<void> _fetchUserCount() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        querySnapshot.docs.forEach((doc) {
          userCount = querySnapshot.docs.isNotEmpty ? userCount + 1 : userCount;
        });
        userCount = userCount - 1;
      });
    } catch (error) {
      print('Error fetching user count: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 11, 83, 81),
                    Color.fromARGB(
                        255, 0, 169, 165), // your activity container color
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Activity',
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildDateBoxes(),
                  SizedBox(height: 20.0),
                  SizedBox(height: 10.0),
                  Text(
                    'Your activity over the last 5 days',
                    style: TextStyle(
                      color: white,
                      //   fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], //community stats container color
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Community Stats',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _buildCommunityActivityGraph(),
                  SizedBox(height: 20.0),
                  const Text(
                    'Placeholder for community stats',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(
                        255, 11, 83, 81), //colors for total users container
                    const Color.fromARGB(255, 0, 169, 165)
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Users',
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildUsersBoxes(userCount),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 10.0),
                  Text(
                    'Registererd users on Elaros',
                    style: TextStyle(
                      color: white,
                      //  fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersBoxes(int userCount) {
    List<Widget> usersBoxe = [];
    for (int i = 0; i < 1; i++) {
      usersBoxe.add(_buildUsersBox(userCount, i == 0));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: usersBoxe,
    );
  }

  Widget _buildUsersBox(int totalUsers, bool isSelected) {
    return Container(
      height: 110,
      width: 100.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.8) : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Text(
            totalUsers.toString(),
            style: TextStyle(
              color: white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Users",
            style: TextStyle(
              color: white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBoxes() {
    List<Widget> dateBoxes = [];
    for (int i = 0; i < 3; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));
      dateBoxes.add(_buildDateBox(date, i == 0));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dateBoxes,
    );
  }

  Widget _buildDateBox(DateTime date, bool isSelected) {
    String formattedDate = '${date.day}';
    String dayOfWeek = _getDayOfWeek(date.weekday);
    return Container(
      height: 110,
      width: 100.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.8) : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey, // Border color
          width: 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Text(
            formattedDate,
            style: TextStyle(
              color: white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            dayOfWeek,
            style: TextStyle(
              color: white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  Widget _buildCommunityActivityGraph() {
    return Container(
      height: 200.0,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 2),
                FlSpot(3, 4),
                FlSpot(4, 3),
                FlSpot(5, 1),
                FlSpot(6, 3),
                FlSpot(7, 2),
                FlSpot(8, 4),
                FlSpot(9, 3),
              ],
              isCurved: true,
              color: purple,
              barWidth: 4,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatsSection() {
    List<String> recommendedTasks = [
      'Take a COVID-19 test on Monday',
      'Take a COVID-19 test on Wednesday',
      'Take a COVID-19 test on Friday',
      'Take a COVID-19 test on Sunday',
    ];

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Tasks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recommendedTasks.map((task) {
              return Text(
                task,
                style: TextStyle(fontSize: 16.0),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
