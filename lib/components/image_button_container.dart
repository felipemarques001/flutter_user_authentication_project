import 'package:flutter/material.dart';

class ImageButtonContainer extends StatelessWidget {
  final String imagePath;

  const ImageButtonContainer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        imagePath,
        height: 30,
      ),
    );
  }
}
