import 'package:flutter/material.dart';
import 'package:elaros/login_page.dart';
// Add this import
import 'package:elaros/tabs/health_tab.dart';
import 'package:elaros/tabs/home_tab.dart';
import 'package:elaros/tabs/resources_tab.dart';
import 'package:elaros/tabs/stats_tab.dart';
import 'package:elaros/tabs/support_tab.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcePage> { // Add the type for State class
  int _selectedTab = 0;

  final List _pages = [
    const Center(
      child: HomeTab(),
    ),
    const Center(
      child: SupportTab(),
    ),
    const Center(
      child: HealthTab(),
    ),
    const ResourcesTab(), // Use ResourcesTab directly
    const Center(
      child: StatsTab(),
    ),
  ];

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
          title: const SizedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 25.0, left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, John",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff3C5C6C),
                    ),
                  ),
                  Text(
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
                  const PopupMenuItem(
                    value: "profile",
                    child: Row(
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
                  ),
                  const PopupMenuItem(
                    value: "settings",
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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
      ),
    );
  }
}
