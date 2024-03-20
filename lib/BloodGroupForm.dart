import 'package:elaros/home_page.dart';
import 'package:elaros/models/bloodGroupModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BloodGroupForm extends StatefulWidget {
  const BloodGroupForm({Key? key}) : super(key: key);

  @override
  State<BloodGroupForm> createState() => _BloodGroupFormState();
}

class _BloodGroupFormState extends State<BloodGroupForm> {
  final _formKey = GlobalKey<FormState>();
  String bloodGroup = '-';
  var selected = "-";
  final bloogGroupController = TextEditingController();
  List<String> bloodGroupsList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  updateBloodGroup() async {
    bloodGroupModel user = bloodGroupModel(
      bloodgroup: bloodGroup,
    );

    updateBloodgroupFirebase(user, FirebaseAuth.instance.currentUser!.uid);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 50, 255, 142),
        content: Text(
          "Blood Type Updated",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Blood Group',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff3C5C6C),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton(
                  hint: const Text('Please select your blood group'),
                  onChanged: (newValue) {
                    setState(() {
                      bloodGroup = newValue!;
                    });
                  },
                  items: bloodGroupsList.map((bloodGroup) {
                    return DropdownMenuItem(
                      value: bloodGroup,
                      child: Text(bloodGroup),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // setState(() {
                      //   bloodGroup = bloogGroupController.text;
                      // });
                      updateBloodGroup();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3C5C6C),
                    foregroundColor: const Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
