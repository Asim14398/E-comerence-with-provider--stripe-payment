import 'package:flutter/material.dart';

class Image1 extends StatelessWidget {
  const Image1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200, // Adjust width as needed
        height: 200, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          image: DecorationImage(
            image: AssetImage('images/boat.jpg'), // Replace with your image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),
        ),

      ),
    );
  }
}
