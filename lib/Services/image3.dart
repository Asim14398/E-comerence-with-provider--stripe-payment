import 'package:flutter/material.dart';

class Image3 extends StatelessWidget {
  const Image3({super.key});

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
            image: AssetImage('images/pants.jpg'), // Replace with your image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),
        ),

      ),
    );
  }
}
