import 'package:flutter/material.dart';
import 'package:elaros/home_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                      const Padding(
                        padding: EdgeInsets.only(left: 40.0, top: 20.0),
                        child: Column(
                          children: [
                            Text("Steps Count", style: TextStyle(fontSize: 14.0),),
                            Text("850", style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold ),),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Image.asset(
                          "assets/images/steps_count.png",
                          width: width * 0.2,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.43,
                    height: 110,
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFAAF41),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 40.0, top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Blood Group", style: TextStyle(fontSize: 14.0),),
                                Text("B+", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold ),),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              "assets/images/blood_group.png",
                              width: width * 0.1,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.43,
                    height: 110,
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffEC6C20),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 40.0, top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Weight", style: TextStyle(fontSize: 14.0),),
                                Row(
                                  children: [
                                    Text("72", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold ),),
                                    Padding(
                                      padding: EdgeInsets.only(top: 23.0, left: 5.0),
                                      child: Text("kg", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              "assets/images/weight.png",
                              width: width * 0.09,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 20,),
              Container(
                width: width * 0.9,
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
                            Text("Activities", style: TextStyle(fontSize: 14.0),),
                            Row(
                              children: [
                                Text("11/18", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold ),),
                                Padding(
                                  padding: EdgeInsets.only(top: 18.0, left: 5.0),
                                  child: Text("workouts completed", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          "assets/images/activities.png",
                          width: width * 0.12,
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text("  OUR SOLUTIONS", textAlign: TextAlign.right, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xff3C5C6C)),),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 10,),
                            const Text("C19-YRS™", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 10,),
                            const Text("Mi-Trial ®", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 10,),
                            const Text("Neu-Restore™", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 15,),
                            Image.asset(
                              "assets/images/4.png",
                            ),
                            const SizedBox(height: 15,),
                            const Text("CQI Toolkit™", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 18,),
                            Image.asset(
                              "assets/images/5.png",
                            ),
                            const SizedBox(height: 18,),
                            const Text("Hydr8™", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 10,),
                            const Text("Sleepy Fox™", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 2,),
                            const Text("The Care Home Guide to Dysphagia", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.21,
                    height: 120,
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
                            const SizedBox(height: 10,),
                            const Text("The Digital Bladder Diary™", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xff3C5C6C)),),
                          ],
                        )
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text("  GET MORE FROM HEALTH", textAlign: TextAlign.right, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xff3C5C6C)),),
                ),
              ),
              const SizedBox(height: 10,),
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
                      const SizedBox(height: 10,),
                      Image.asset(
                        "assets/images/health.png",
                        width: width * 0.2,
                      ),
                      const SizedBox(height: 10,),
                      const Text("Update My Health", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text("In an Emergency, it's important that first responders have up-to-date information.", style: TextStyle(fontSize: 14.0),),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: width * 0.8,
                        height: 45,
                        child: ElevatedButton(
                          child: const Text('Update'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3C5C6C),
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
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text("  NEWS", textAlign: TextAlign.right, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Color(0xff3C5C6C)),),
                ),
              ),
              const SizedBox(height: 10,),
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
                      const SizedBox(height: 20,),
                      Image.asset(
                        "assets/images/thebmj.png",
                        width: width * 0.2,
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text("Impact of Long COVID quantified by the European Journal of Health Economics.", style: TextStyle(fontSize: 14.0),),
                      ),
                      const SizedBox(height: 10,),
                      const Text("December 26, 2023", style: TextStyle(fontSize: 13.0, color: Colors.grey),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
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
                      const SizedBox(height: 20,),
                      Image.asset(
                        "assets/images/logo.png",
                        width: width * 0.2,
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                        child: Text("ELAROS appoints Daniel Weatherill as Trainee Management Accountant", style: TextStyle(fontSize: 14.0),),
                      ),
                      const SizedBox(height: 10,),
                      const Text("September 18, 2023", style: TextStyle(fontSize: 13.0, color: Colors.grey),),
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
