import 'package:flutter/material.dart';

class HealthTab extends StatelessWidget {
  const HealthTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("Health tab"),
            ],
          ),
        ),
      ),
    );
  }
}
