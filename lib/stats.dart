import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final String id;

  Event({
    required this.title,
    this.description,
    required this.date,
    required this.id,
  });
}

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late Map<DateTime, List<Event>> _events = {};
  late List<Event> _selectedEvents;
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
    _initializeEvents();
    _fetchLastCompletionDate();
    _calculateDaysUntilNextAssessment();
  }

  Future<void> _fetchLastCompletionDate() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('assessments')
          .orderBy('completionDate', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
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

  void _calculateDaysUntilNextAssessment() {
    if (_lastCompletionDate != null) {
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

  Future<void> _initializeEvents() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email ?? '';

      final eventsRef = FirebaseFirestore.instance.collection('C19-responses');
      final snapshot = await eventsRef.where('userEmail', isEqualTo: userEmail).get();

      final events = <DateTime, List<Event>>{};

      for (final doc in snapshot.docs) {
        final completionDate = (doc.data() as Map<String, dynamic>)['completionDate'].toDate();
        final event = Event(
          title: 'Assessment Completed',
          description: 'Assessment completed on ${DateFormat('yyyy-MM-dd').format(completionDate)}',
          date: completionDate,
          id: doc.id,
        );

        final date = DateTime.utc(event.date.year, event.date.month, event.date.day);

        if (events[date] == null) {
          events[date] = [];
        }
        events[date]!.add(event);
      }

      setState(() {
        _events = events;
      });
}
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay ?? _focusedDay, day);
      },
      eventLoader: (day) {
        return _events[day] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _selectedEvents = _events[selectedDay] ?? [];
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final eventCount = events.length;

          if (eventCount > 0) {
            return Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
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
                    Color.fromARGB(255, 0, 169, 165),
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
                  _buildCalendar(),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
Color.fromARGB(255, 11, 83, 81),
                    Color.fromARGB(255, 0, 169, 165),
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
                  _buildUsersBoxes(userCount),
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