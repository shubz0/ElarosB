import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/features/find_support_page/find_support_page.dart';
import 'package:elaros/features/authentication/screens/login_page.dart';
import 'package:elaros/features/my_health_page/health_page.dart';
import 'package:elaros/features/profile_page/profile_page.dart';
import 'package:elaros/features/stats_page/stats_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elaros/features/home_page/home_tab.dart';
import 'package:elaros/features/resources_page/resources_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  int _selectedTab = 0;

  final List _pages = [
    const Center(
      child: HomeTab(),
    ),
    Center(
      child: FindSupportPage(),
    ),
    const Center(
      child: MyHealthPage(),
    ),
    const Center(
      child: ResourcesTab(),
    ),
    const Center(
      child: StatsPage(),
    ),
  ];

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 11, 83, 81),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15.0),
              child: Container(
                color: const Color.fromARGB(255, 11, 83, 81),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: getCurrentUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            var name = snapshot.data;
                            return Text(
                              'Hi, $name',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    const Text(
                      "Elaros is here for you",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 15.0),
                child: PopupMenuButton(
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/images/profile.png",
                    ),
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: "profile",
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: "logout",
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        _logOut();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: _pages[_selectedTab],
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: const Color.fromARGB(255, 11, 83, 81),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedTab,
            onTap: (index) => _changeTab(index),
            selectedItemColor: const Color.fromARGB(255, 144, 194, 231),
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontSize: 10),
            unselectedLabelStyle: const TextStyle(fontSize: 8),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.support_agent_outlined),
                  label: "Find Support"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.health_and_safety_outlined),
                  label: "My Health"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services_outlined),
                  label: "Resources"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded), label: "Stats"),
            ],
          ),
        ));
  }

  Future<String> getCurrentUserName() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      var data = snapshot.data();
      if (data != null && data is Map && data.containsKey('name')) {
        return data['name'];
      } else {
        throw Exception('Name not found in user document');
      }
    } else {
      throw Exception('User not signed in');
    }
  }
}
