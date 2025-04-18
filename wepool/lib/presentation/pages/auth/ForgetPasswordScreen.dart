import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wepool/presentation/provider/ForgetPasswordProvider.dart';
import 'package:wepool/utils/colors.dart';
import 'package:wepool/widgets/global/GlobalOutlinEditText.dart';

import '../../../widgets/global/GlobalRoundedButton.dart';
import 'OtpVerificationScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      // Hide keyboard on tap
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<ForgetPasswordProvider>(
            builder: (context, forgetPasswordProvider, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (forgetPasswordProvider.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(forgetPasswordProvider.errorMessage),
                      backgroundColor: Colors.red, // Error styling
                      duration: Duration(seconds: 3),
                    ),
                  );
                  forgetPasswordProvider
                      .clearError(); // Clear error message after showing
                }
              });
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 56, 22, 0),
                      child: Form(
                        key: _formKey, // ✅ Wrap with Form for validation
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🔹 Back Button
                            GlobalRoundedBtn(
                              onPressed: () => Navigator.pop(context),
                              height: 50,
                              width: 50,
                            ),

                            /// 🔹 Title
                            const SizedBox(height: 25),
                            Text(
                              "Forgot password",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1,
                              ),
                            ),

                            /// 🔹 Subtitle
                            Text(
                              "Enter your email to reset the password",
                              style: GoogleFonts.poppins(
                                color: AppColors.gray001,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -1,
                              ),
                            ),

                            /// 🔹 Email Input Field
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: GlobalOutlineEditText(
                                hintText: "Enter your email",
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                  ).hasMatch(value)) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            /// 🔹 Submit Button
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    forgetPasswordProvider.setEmail(_emailController.text);
                                    forgetPasswordProvider.getOtp(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: AppColors.primary,
                                ),
                                child: Text(
                                  "Reset Password",
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
