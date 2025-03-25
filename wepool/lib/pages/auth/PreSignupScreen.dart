import 'package:flutter/material.dart';
import 'package:wepool/utils/colors.dart';
import '../../widgets/global/HoloCircularIndicatorWithChild.dart';
import 'LoginScreen.dart';

class PreSignupScreen extends StatefulWidget {
  @override
  _PreSignupScreenState createState() => _PreSignupScreenState();
}

class _PreSignupScreenState extends State<PreSignupScreen> {
  int _currentIndex = 0;
  double _opacity = 1.0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/img_presignup_1.png",
      "title": "Ride & Share",
      "subtitle": "Get colleagues who are going in the same office on your way!",
    },
    {
      "image": "assets/images/img_presignup_2.png",
      "title": "Travel Together",
      "subtitle": "Enjoy your commute with friendly colleagues.",
    },
    {
      "image": "assets/images/img_presignup_3.png",
      "title": "Save Fuel & Money",
      "subtitle": "Share rides and contribute to a greener planet.",
    },
  ];

  void _nextStep() {
    if (_currentIndex < onboardingData.length - 1) {
      setState(() => _opacity = 0); // Start fade-out animation

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _currentIndex++;
          _opacity = 1; // Fade-in new content
        });
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,// ✅ Fix: Correct syntax
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final currentData = onboardingData[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Image with Margin Instead of SizedBox
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _opacity,
              child: Container(
                margin: EdgeInsets.only(bottom: 20), // Replaces SizedBox(height: 20)
                child: Image.asset(currentData['image']!, width: 260, height: 260),
              ),
            ),

            // Animated Title with Margin
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _opacity,
              child: Container(
                margin: EdgeInsets.only(bottom: 8), // Replaces SizedBox(height: 20)
                child: Text(
                  currentData['title']!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),

            // Animated Subtitle with Padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _opacity,
                child: Container(
                  margin: EdgeInsets.only(bottom: 80), // Replaces SizedBox(height: 20)
                  child: Text(
                    currentData['subtitle']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
              ),
            ),

            // Circular Progress Indicator with Button
            HoloCircularIndicatorWithChild(
              progress: (_currentIndex + 1) / onboardingData.length,
              size: 85,
              strokeWidth: 4,
              child: Container(
                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                height: 73,
                width: 73,
                child: IconButton(
                  onPressed: _nextStep,
                  icon: Icon(
                    _currentIndex < onboardingData.length - 1 ? Icons.arrow_forward : Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: PreSignupScreen()));
}
