import 'package:flutter/material.dart';

class MyReusableButton extends StatelessWidget {
  const MyReusableButton({
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
            SizedBox(
              width: 200,
              height: 120,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
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
