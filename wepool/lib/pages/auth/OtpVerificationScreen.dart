import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wepool/utils/colors.dart';
import '../../widgets/global/GlobalRoundedButton.dart';
import 'PrePasswordResetScreen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());
  int _secondsRemaining = 30;
  bool _isResendActive = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  void _startResendCountdown() {
    _isResendActive = false;
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() => _isResendActive = true);
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      print("OTP Entered: $otp");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PrePasswordResetScreen())); // Replace with API call
    } else {
      print("Please enter a 4-digit OTP");
    }
  }

  /// Formats email as "abc...@domain.com"
  String getFormattedEmail(String email) {
    if (!email.contains("@")) return email;
    List<String> parts = email.split("@");
    String firstPart = parts[0].length > 3 ? parts[0].substring(0, 3) : parts[0];
    return "$firstPart...@${parts[1]}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // Hide keyboard on tap
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView( // Ensures content doesn't overflow on small screens
          child: Padding(
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
                const SizedBox(height: 25),
                Text(
                  "Check your email",
                  style: GoogleFonts.poppins(
                    fontSize: 28, // Reduced font size
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5, // Reduced letter spacing
                  ),
                ),

                /// 🔹 Subtitle with formatted email
                const SizedBox(height: 8),
                Text(
                  "We sent a reset link to ${getFormattedEmail(widget.email)}\nEnter the 4-digit code",
                  style: GoogleFonts.poppins(
                    color: AppColors.gray001,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5,
                  ),
                  softWrap: true,
                ),

                /// 🔹 OTP Input Fields with Spacing
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          SizedBox( // Space between boxes
                            width: index > 0 ? 12 : 0,
                          ),
                          SizedBox(
                            width: 50, // Ensures uniform width
                            child: TextField(
                              controller: _otpControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.gray002),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.primary),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),

                /// 🔹 Resend OTP Timer & Button
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isResendActive
                          ? ""
                          : "Resend OTP in $_secondsRemaining s",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.gray003,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: _isResendActive
                          ? () {
                        _startResendCountdown();
                        print("Resend OTP triggered"); // API call here
                      }
                          : null,
                      child: Text(
                        "Resend OTP",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: _isResendActive
                              ? AppColors.primary
                              : AppColors.gray003,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                /// 🔹 Verify Button
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      "Verify",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// 🔹 Extra Padding to Prevent Keyboard Overlap
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
