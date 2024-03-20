import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/BloodGroupForm.dart';
import 'package:elaros/WeightForm.dart';
import 'package:elaros/health_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedometer/pedometer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final weightController = TextEditingController();
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<String> getCurrentBloodGroup() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      var data = snapshot.data();
      if (data != null && data is Map && data.containsKey('bloodgroup')) {
        return data['bloodgroup'];
      } else {
        throw Exception('--');
      }
    } else {
      throw Exception('User not signed in');
    }
  }

  Future<String> getCurrentWeight() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      var data = snapshot.data();
      if (data != null && data is Map && data.containsKey('weight')) {
        return data['weight'];
      } else {
        throw Exception('--');
      }
    } else {
      throw Exception('User not signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool _isHovered = false;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: width * 0.9,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffDEF4FF),
                ),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, top: 20.0),
                            child: Column(
                              children: [
                                const Text(
                                  "Steps Count",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  _steps,
                                  style: const TextStyle(
                                      fontSize: 44.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Image.asset(
                            "assets/images/steps_count.png",
                            width: width * 0.2,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => BloodGroupForm()),
                    );
                  },
                  child: Container(
                    width: width * 0.43,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 0, 169, 165),
                    ),
                    child:
                        Wrap(alignment: WrapAlignment.spaceBetween, children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 20.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Blood Group",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              FutureBuilder(
                                future: getCurrentBloodGroup(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    if (snapshot.hasError) {
                                      return const Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 35.0,
                                        ),
                                      );
                                    } else {
                                      var bloodgroup = snapshot.data;
                                      return Text(
                                        '$bloodgroup',
                                        style: const TextStyle(
                                            fontSize: 35.0,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: Image.asset(
                      //     "assets/images/blood_group.png",
                      //     width: width * 0.09,
                      //   ),
                      // ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => WeightForm()),
                    );
                  },
                  child: Container(
                    width: width * 0.43,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 144, 194, 231),
                    ),
                    child:
                        Wrap(alignment: WrapAlignment.spaceBetween, children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, top: 20.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Weight",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Row(
                                children: [
                                  FutureBuilder(
                                    future: getCurrentWeight(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else {
                                        if (snapshot.hasError) {
                                          return const Text(
                                            '-',
                                            style: TextStyle(
                                              fontSize: 35.0,
                                            ),
                                          );
                                        } else {
                                          var weight = snapshot.data;
                                          return Text(
                                            '$weight',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 23.0, left: 3.0),
                                    child: Text(
                                      "kg",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                      // Padding(
                      //   padding: const EdgeInsets.all(15.0),
                      //   child: Image.asset(
                      //     "assets/images/weight.png",
                      //     width: width * 0.08,
                      //   ),
                      // ),
                    ]),
                  ),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF5F5F5),
                ),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 40.0, top: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Activities",
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "0/4",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 16.0, left: 5.0),
                                      child: Text(
                                        "completed",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset(
                            "assets/images/activities.png",
                            width: width * 0.12,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text(
                    "  OUR SOLUTIONS",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 83, 81)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch('https://www.elaros.com/solutions/c19-yrs/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/1.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "C19-YRS™",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch('https://www.elaros.com/solutions/mi-trial/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/2.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Mi-Trial ®",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch(
                              'https://www.elaros.com/solutions/neu-restore/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/3.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Neu-Restore™",
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch(
                              'https://www.elaros.com/solutions/cqi-toolkit/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Image.asset(
                                      "assets/images/4.png",
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "CQI Toolkit™",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch('https://www.elaros.com/solutions/hydr8/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Image.asset(
                                      "assets/images/5.png",
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      "Hydr8™",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch(
                              'https://www.elaros.com/solutions/sleepy-fox/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/6.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Sleepy Fox™",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch(
                              'https://www.elaros.com/solutions/the-care-home-guide-to-dysphagia/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/7.png",
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text(
                                      "The Care Home Guide to Dysphagia",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (event) => setState(() => _isHovered = true),
                      onExit: (event) => setState(() => _isHovered = false),
                      child: InkWell(
                        onTap: () {
                          launch(
                              'https://www.elaros.com/solutions/the-digital-bladder-diary/');
                        },
                        splashColor: const Color.fromARGB(255, 0, 0, 0),
                        child: Container(
                          width: 80,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/8.png",
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "The Digital Bladder Diary™",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff3C5C6C)),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text(
                    "  GET MORE FROM HEALTH",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 83, 81)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width * 0.9,
                height: 265,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/images/health.png",
                        width: width * 0.2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Update My Health",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text(
                          "In an Emergency, it's important that first responders have up-to-date information.",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        height: 45,
                        child: ElevatedButton(
                          child: const Text('Update'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const MyHealthPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 11, 83, 81),
                            foregroundColor: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text(
                    "  NEWS",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 83, 81)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MouseRegion(
                onEnter: (event) => setState(() => _isHovered = true),
                onExit: (event) => setState(() => _isHovered = false),
                child: InkWell(
                  onTap: () {
                    launch('https://www.elaros.com/news-and-updates/');
                  },
                  splashColor: const Color.fromARGB(255, 0, 0, 0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 11, 83, 81),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'News',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width * 0.9,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/thebmj.png",
                        width: width * 0.2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text(
                          "Impact of Long COVID quantified by the European Journal of Health Economics.",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "December 26, 2023",
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width * 0.9,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/logoelaros.png",
                        width: width * 0.2,
                        // height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text(
                          "ELAROS appoints Daniel Weatherill as Trainee Management Accountant",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "September 18, 2023",
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
