import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Resources',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff3C5C6C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SizedBox(height: 7),
            CustomButton(
              label: 'Long Covid Help',
              url: 'https://www.youtube.com/watch?v=fQM2oE-wBSE',
              icon: Icons.health_and_safety_outlined,
            ),
            SizedBox(height: 7),
            CustomButton(
              label: 'Breathlessness support',
              url: 'https://www.example.com/button2',
              icon: Icons.local_hospital_outlined,
            ),
            SizedBox(height: 7),
            CustomButton(
              label: 'Chest pains',
              url: 'https://www.example.com/button3',
              icon: Icons.local_hotel_rounded,
            ),
            SizedBox(height: 7),
            CustomButton(
              label: 'Drowsiness',
              url: 'https://www.example.com/button4',
              icon: Icons.medical_information_outlined,
            ),
            SizedBox(height: 7),
            CustomButton(
              label: 'Loss of smell and taste',
              url: 'https://www.example.com/button5',
              icon: Icons.food_bank_outlined,
            ),
            SizedBox(height: 7),
            CustomButton(
              label: 'Headaches',
              url: 'https://www.example.com/button6',
              icon: Icons.medication_outlined,
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String label;
  final String url;
  final IconData? icon;

  const CustomButton({
    required this.label,
    required this.url,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          launch(widget.url);
        },
        splashColor: const Color.fromARGB(255, 0, 0, 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 65,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.orangeAccent : Colors.orange,
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8), // Space between icon and text
                ],
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
