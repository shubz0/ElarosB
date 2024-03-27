import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Import TableCalendar package

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int userCount = 0;
  int _daysUntilNextAssessment = 0;
  DateTime? _lastCompletionDate;

  @override
  void initState() {
    super.initState();
    _fetchUserCount();
    _initializeEvents(); // Initialize events for the calendar
    _fetchLastCompletionDate(); // Fetch last completion date from Firestore
    _calculateDaysUntilNextAssessment(); // Calculate days until next assessment
  }

  // Fetch last completion date from Firestore
  void _fetchLastCompletionDate() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('assessments')
          .orderBy('completionDate', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Get the completion date from the first document
        DateTime completionDate = (querySnapshot.docs.first.data()
                as Map<String, dynamic>)['completionDate']
            .toDate();
        setState(() {
          _lastCompletionDate = completionDate;
        });
      }
    } catch (error) {
      print('Error fetching last completion date: $error');
    }
  }

  // Calculate days until next assessment
  void _calculateDaysUntilNextAssessment() {
    if (_lastCompletionDate != null) {
      // Calculate the difference in days between today and the last completion date
      Duration difference = _lastCompletionDate!.difference(DateTime.now());
      setState(() {
        _daysUntilNextAssessment = difference.inDays;
      });
    }
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

  // Initialize events for the calendar
  void _initializeEvents() {
    // Example: Assign some events to specific dates
    _events = {
      DateTime.now().subtract(Duration(days: 2)): ['Event A'],
      DateTime.now().subtract(Duration(days: 1)): ['Event B'],
      DateTime.now(): ['Event C', 'Event D'],
      DateTime.now().add(Duration(days: 1)): ['Event E'],
    };
    // Set initial selected events to today's events
    _selectedEvents = _events[DateTime.now()] ?? [];
  }

  Widget _buildCalendar() {
    return TableCalendar(
      // Configuration for the calendar
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        // Use _selectedDay if it is set, otherwise use _focusedDay
        return isSameDay(_selectedDay ?? _focusedDay, day);
      },
      eventLoader: (day) {
        // Load events for the specified day from _events
        return _events[day] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // update _focusedDay as well
          _selectedEvents = _events[selectedDay] ?? [];
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay; // update _focusedDay
      },
      calendarBuilders: CalendarBuilders(
        // Customize day cell builder
        defaultBuilder: (context, day, focusedDay) {
          return _buildDayCell(day);
        },
      ),
    );
  }

  Widget _buildDayCell(DateTime day) {
    final isCompleted = _events.containsKey(day);
    final isReminder = _lastCompletionDate != null &&
        day.difference(_lastCompletionDate!) == Duration(days: 14);
    final isDue = _daysUntilNextAssessment > 0 &&
        day == DateTime.now().add(Duration(days: _daysUntilNextAssessment));

    return Container(
      margin: EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.white
            : (isReminder ? Colors.yellow : (isDue ? Colors.red : null)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        day.day.toString(),
        style: TextStyle(
          color: isCompleted ? Colors.black : Colors.white,
        ),
      ),
    );
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildCalendar(), // Display the calendar
                  SizedBox(height: 20.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Remember to take an assessment every 14 days',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(
                        255, 11, 83, 81), //colors for total users container
                    Color.fromARGB(255, 0, 169, 165)
                  ],
                ),
                borderRadius: BorderRadius.only(
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildUsersBoxes(userCount), // Pass user count
                  SizedBox(height: 20.0),
                  SizedBox(height: 10.0),
                  Text(
                    'Registered users on Elaros',
                    style: TextStyle(
                      color: Colors.white,
                      //  fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersBoxes(int userCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUsersBox(userCount, isSelected: true),
      ],
    );
  }

  Widget _buildUsersBox(int totalUsers, {required bool isSelected}) {
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
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Users",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
