import 'package:flutter/material.dart';

class FindSupportPage extends StatefulWidget {
  @override
  _FindSupportPageState createState() => _FindSupportPageState();
}

class _FindSupportPageState extends State<FindSupportPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff3C5C6C),
                  Color(0xff3C5C6C),
                ],
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Find Support Page",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff3C5C6C),
                  Colors.white,
                ],
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "We're here to Support you in All Ways Possible. We can Locate the nearest Clinic to you for an In Person Assessment. Start by entering your Postcode.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Enter Your Postcode",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _searchLocations,
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xff3C5C6C)), //search btn color
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xff3C5C6C); //color of text on btn press
                        return Colors.white; //default color of text in btn
                      })),
                ),
                SizedBox(height: 20), //padding below the search btn
                Expanded(
                  child: Container(
                    //container for search results
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 215, 213, 213),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _results.isEmpty
                        ? Center(
                            child: Text(
                                'Your nearest clinics will be displayed here',
                                style: TextStyle(
                                  color: Colors.black,
                                )))
                        : Column(
                            children: [
                              SizedBox(height: 20),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _results.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Align(
                                        alignment: Alignment.center,
                                        child: Text(_results[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 4,
                  color: Color(0xff3C5C6C),
                ), //divider between search results and contact us

                Container(
                  //contact us container
                  padding: EdgeInsets.all(10),
                  color: Color(0xff3C5C6C),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact Us',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      SizedBox(height: 10),
                      Text(
                        'Email: contact@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Phone: +123 456 789',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  void _searchLocations() {
    setState(() {
      _results = List.generate(
          5,
          (index) =>
              'Placeholder Location ${index + 1}'); //placeholder results list
    });
  }
}
