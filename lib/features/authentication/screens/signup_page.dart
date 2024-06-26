import 'package:elaros/features/home_page/home_page.dart';
import 'package:elaros/features/authentication/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";
  var name = "";
  var username = "";
  var address = "";
  var gender = "male";
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    usernameController.dispose();
    addressController.dispose();
    genderController.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        UserModel user = UserModel(
          name: name,
          username: username,
          address: address,
          gender: gender,
          bloodgroup: '',
          weight: '',
        );

        addUserToFirestore(user, FirebaseAuth.instance.currentUser!.uid);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 50, 255, 142),
            content: Text(
              "Registered Successfully. Logging you in..",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black), //feedback to user input for better UX
            ),
          ),
        );
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Account Already Exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 64, 64),
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 169, 165),
            body: SingleChildScrollView(
                child: Column(children: [
              Center(
                child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  height: height * 0.38,
                ),
              ),
              Center(
                child: SizedBox(
                  height: height * 0.58,
                  width: width * 1,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      //scrollable form to avoid overflow issues with keyboard
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Signup',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: false,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Full Name',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: false,
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Username',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: false,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                } else if (!value.contains('@')) {
                                  return 'Please Enter Valid Email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Email',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Password',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: true,
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Confirm Password',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              obscureText: false,
                              controller: addressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                hintText: 'Address',
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width * 0.62,
                            child: const Text(
                              'Gender: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ListTile(
                                      title: const Text(
                                        'Male',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      leading: Radio(
                                        value: 'male',
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value!;
                                            genderController.text = 'male';
                                          });
                                        },
                                        activeColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: ListTile(
                                      title: const Text(
                                        'Female',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      leading: Radio(
                                        value: 'female',
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value!;
                                            genderController.text = 'female';
                                          });
                                        },
                                        activeColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: ExpansionTile(
                                  //expansion tile for better UX rather than overwhelming with a dedicated page, pop up window etc.
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                        checkColor: Colors.white,
                                        activeColor: Colors.green,
                                      ),
                                      const Flexible(
                                          child: Text(
                                        'Terms & Conditions',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))
                                    ],
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Your Terms and Conditions\nTick the Box Above to Agree',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: width * 0.80,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children: [
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 11, 83, 81),
                                            foregroundColor:
                                                const Color(0xffffffff),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: const Text('LOGIN'),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: 120,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                email = emailController.text;
                                                password =
                                                    passwordController.text;
                                                confirmPassword =
                                                    confirmPasswordController
                                                        .text;
                                                name = nameController.text;
                                                username =
                                                    usernameController.text;
                                                address =
                                                    addressController.text;
                                                gender = genderController.text;
                                              });
                                              registration();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff3C5C6C),
                                            foregroundColor:
                                                const Color(0xffffffff),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: const Text('REGISTER'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: FractionallySizedBox(
                                    widthFactor: 1.3,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      child: Image.asset(
                                        'assets/images/ellipse.png', //cutout effect as seen on login page
                                        width: width * 0.7,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]))));
  }
}
