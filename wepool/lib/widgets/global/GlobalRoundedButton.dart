import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class GlobalRoundedBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? height;
  final double? width; // Explicitly define the type

  const GlobalRoundedBtn({
    super.key,
    required this.onPressed,
    this.height = 41.0,  // Provide a default value
    this.width = 41.0,   // Provide a default value
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed, // Call the function passed from the parent
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width!, height!), // Handle null safety
        maximumSize: Size(width!, height!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.grey.shade300), // Light border color
        padding: const EdgeInsets.all(12), // Padding for better touch area
        backgroundColor: Colors.white, // Background color
      ),
      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
    );
  }
}
