import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros/home_page.dart';
import 'package:elaros/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elaros/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var email = "";
  var password = "";
  var confirmPassword = "";
  var name = "";
  var username = "";
  var address = "";
  var gender = "";
  String bloodGroup = '';
  String weight = '-';

  // final emailController = TextEditingController();
  // final nameController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  // final usernameController = TextEditingController();
  // final addressController = TextEditingController();
  // final genderController = TextEditingController();
  // final bloodgroupController = TextEditingController();
  // final weightController = TextEditingController();

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

  Future getCurrentUser() async {
    print('Current user Fetch');
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    if (user != null) {
      print('user not null');
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(user.uid).get();
      var data = snapshot.data();
      print(data);
      if (data != null && data is Map) {
        username = data['username'];
        name = data['name'];
        address = data['address'];
        gender = data['gender'];
        bloodGroup = data['bloodgroup'];
        weight = data['weight'];
      } else {
        throw Exception('Username not found in user document');
      }
    } else {
      throw Exception('User not signed in');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    getCurrentUser();

    super.initState();
  }

  Widget textFieldWidget(String? initialValue, String hintText,
      String titleText, void Function(String?)? onSaved) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff3C5C6C),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onSaved: onSaved,
          initialValue: '$initialValue',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter $titleText';
            }
            return null;
          },
          decoration: InputDecoration(
            // border: InputBorder.none,
            contentPadding: const EdgeInsets.all(14),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff3C5C6C),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff3C5C6C),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
          ),
          // 'Name: , $name',
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xff3C5C6C),
          ),
        ),
      ],
    );
  }

  Widget dropdownWidget(String? selectedValue, List<String> items,
      String hintText, String titleText, void Function(String?)? onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff3C5C6C),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          value: selectedValue==''?null:selectedValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff3C5C6C),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff3C5C6C),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
          ),
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xff3C5C6C),
          ),
        ),
      ],
    );
  }

  updateProfile() async {
    UserModel user = UserModel(
      name: name,
      username: username,
      address: address,
      gender: gender,
      bloodgroup: bloodGroup,
      weight: weight,
    );

    updateUserprofile(user, FirebaseAuth.instance.currentUser!.uid);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 50, 255, 142),
        content: Text(
          "Profile updated",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff3C5C6C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isLoading
                  ? const Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: SingleChildScrollView()),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textFieldWidget(name, 'Name', 'Name', (val) {
                            name = val ?? '';
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          textFieldWidget(username, 'Username', 'Username',
                              (val) {
                            username = val ?? '';
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          textFieldWidget(address, 'Address', 'Address', (val) {
                            address = val ?? '';
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          dropdownWidget(
                            gender,
                            ["male", "female"], // List of dropdown items
                            "Select Gender", // Hint text
                            "Gender", // Title text
                            (newValue) {
                              gender = newValue ?? '';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          dropdownWidget(
                            bloodGroup,
                            bloodGroupsList, // List of dropdown items
                            "Select Blood Group", // Hint text
                            "Blood Group", // Title text
                            (newValue) {
                              bloodGroup = newValue ?? '';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textFieldWidget(
                              weight, 'Enter Weight in Kg', 'Weight', (val) {
                            weight = val ?? '';
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                bool validate =
                                    _formKey.currentState!.validate();
                                if (validate) {
                                  _formKey.currentState?.save();
                                  updateProfile();
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(
                                              0xff3C5C6C)), //search btn color
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const Color(
                                          0xff3C5C6C); //color of text on btn press
                                    }
                                    return Colors
                                        .white; //default color of text in btn
                                  })),
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
