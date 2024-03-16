import 'package:flutter/material.dart';
import 'package:elaros/C19/C19.dart';

// Colors
Color blackPrimary = Color(0xff212131);
Color black = Color(0xff09050D);
Color grey = Color.fromARGB(255, 183, 183, 185);
Color orange = Color(0xffFF815E);
Color white = Color(0xffffffff);
Color purple = Color(0xff613FE5);
Color softPurple = Color(0xffD0C3FF);

Color darkBlue = Color.fromARGB(255, 45, 50, 80);
Color darkishBlue = Color.fromARGB(255, 66, 71, 105);
Color blue = Color.fromARGB(255, 112, 119, 161);
Color lightorange = Color.fromARGB(255, 246, 178, 122);

// Button Style
final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(327, 100),
  backgroundColor: white,
  elevation: 4,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
);

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    Key? key,
    required this.onTap,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final void Function() onTap;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
                width: 200,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black.withOpacity(0.5), // Adjust background color as needed
              ),
              width: 200,
              height: 120,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHealthPage extends StatelessWidget {
  const MyHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health',
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
          // Heading Section
          Container(
            padding: EdgeInsets.all(25.0),
            color: darkBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Health',
                  style: TextStyle(
                    color: white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Today is a good day to check up on yourself!',
                  style: TextStyle(
                    color: grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: EdgeInsets.all(20.0),
              children: [
                _buildTestButton(
                    context, 'C19 Test', 'assets/images/C19-YRS-logo-500px-PNG.png',
                    () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => C19Screen()));
                }),
                _buildTestButton(context, 'Test Results', 'assets/images/export.png',
                    () {
                  // Button 2 functionality
                }),
                _buildTestButton(context, 'Export', 'assets/images/results.png', () {
                  // Button 3 functionality
                }),
                _buildTestButton(context, 'Button 1', 'assets/images/results.png', () {
                  // Button 4 functionality
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(
    BuildContext context,
    String text,
    String imagePath,
    Function() onPressed,
  ) {
    return ReusableButton(
      onTap: onPressed,
      imageUrl: imagePath,
      title: text,
    );
  }
}
