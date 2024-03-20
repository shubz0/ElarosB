import 'package:elaros/home_page.dart';
import 'package:flutter/material.dart';
import 'package:elaros/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-credential':
          print("Invalid credentials");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Invalid credentials",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
          break;
        case 'invalid-email':
          print("Invalid Email");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Invalid Email",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
          break;
        case 'wrong-password':
          print("Wrong Password");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Wrong Password",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
          break;
        case 'user-not-found':
          print("User not found");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "User not found",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
          break;
        case 'user-disabled':
          print("Your account is disabled");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(255, 255, 64, 64),
              content: Text(
                "Your account is disabled",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: height * 0.4,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: width * 0.6,
                    ),
                  ),
                  //   SizedBox(height: 20),
                  Text(
                    'Occupational Health',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Powered by Elaros',
                    //  textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      //   fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: height * 0.5,
                  width: width * 1,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 11, 83, 81),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                      bottom: Radius.circular(0.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Login',
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
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 255, 255, 255),
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
                                        width: 120,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignupPage()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 169, 165),
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
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 110,
                                        height: 45,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                email = emailController.text;
                                                password =
                                                    passwordController.text;
                                              });
                                              userLogin();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 78, 128, 152),
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
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: FractionallySizedBox(
                                    widthFactor: 1.3,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 60),
                                      child: Image.asset(
                                        'assets/images/ellipse.png',
                                        width: width * 0.8,
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
