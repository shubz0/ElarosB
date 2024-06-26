import 'package:elaros/features/home_page/home_page.dart';
import 'package:elaros/features/home_page/models/weight_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightForm extends StatefulWidget {
  const WeightForm({super.key});

  @override
  State<WeightForm> createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  final _formKey = GlobalKey<FormState>();
  String weight = '-';
  final weightController = TextEditingController();

  updateWeight() async {
    WeightModel user = WeightModel(
      weight: weight,
    );

    updateWeightToFirebase(user, FirebaseAuth.instance.currentUser!.uid);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Weight Updated",
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
          'Enter your weight',
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
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  obscureText: false,
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Weight in Kg';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Weight in Kg',
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        weight = weightController.text;
                      });
                      updateWeight();
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
