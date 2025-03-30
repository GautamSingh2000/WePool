import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wepool/utils/colors.dart';
import '../../../widgets/global/GlobalRoundedButton.dart';
import 'SetNewPasswordScreen.dart';

class PrePasswordResetScreen extends StatelessWidget {
  final String resetToken;
  final String email;

  const PrePasswordResetScreen({super.key, required this.resetToken, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 56, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Back Button
            GlobalRoundedBtn(
              onPressed: () => Navigator.pop(context),
              height: 41,
              width: 41,
            ),

            /// 🔹 Title
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Text(
                "Password Reset",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1,
                ),
              ),
            ),

            /// 🔹 Subtitle
            Text(
              "Your password has been successfully reset.\nClick confirm to set a new password",
              style: GoogleFonts.poppins(
                color: AppColors.gray001,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5,
              ),
            ),

            /// 🔹 Verify Button
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              child: ElevatedButton(
                onPressed:() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetNewPasswordScreen(resetToken: resetToken,email: email,)));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primary,
                ),
                child: Text(
                  "Confirm",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
