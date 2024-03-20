import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/find_support.dart';
import 'package:elaros/login_page.dart';
import 'package:elaros/health_page.dart';
import 'package:elaros/profile.dart';
import 'package:elaros/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elaros/tabs/home_tab.dart';
import 'package:elaros/tabs/resources_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State {
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
    Center(
      child: StatsPage(),
    ),
  ];

  Future<void> _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
          title: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: getCurrentUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff3C5C6C),
                            ),
                            );
                        } else {
                          var name = snapshot.data;
                          return Text(
                            'Hi, $name',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff3C5C6C),
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
                      color: Color(0xff3C5C6C),
                    ),
                  ),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
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
                    onTap: (){
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
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
                    onTap: (){
                      _logOut();
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
      body: _pages[_selectedTab],
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color(0xff3C5C6C),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: const Color(0xffEC6C20),
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.support_agent_outlined), label: "Find Support"),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety_outlined), label: "My Health"),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services_outlined), label: "Resources"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded), label: "Stats"),
          ],
        ),
      )
    );
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