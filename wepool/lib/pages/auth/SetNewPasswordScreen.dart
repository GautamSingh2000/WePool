import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../../widgets/global/GlobalOutlinEditText.dart';
import '../../widgets/global/GlobalRoundedButton.dart';
import 'SuccessMessageWidget.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            _isSuccess
                ? SuccessMessageWidget(
                  // Show success message if _isSuccess is true
                  title: "Successful",
                  message:
                      "Congratulations! Your password has been changed. Click continue to login.",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      "/login",
                    ); // Navigate to login
                  },
                )
                : SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(22, 10, 22, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              "Set a new password",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1,
                              ),
                            ),
                          ),

                          /// 🔹 Subtitle
                          Text(
                            "Create a new password",
                            style: GoogleFonts.poppins(
                              color: AppColors.gray001,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.5,
                            ),
                          ),

                          // EditText for new password
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: GlobalOutlineEditText(
                              hintText: "Enter your new password",
                              controller: _newPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              // Hide password initially
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                          ),

                          // EditText for new password
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: GlobalOutlineEditText(
                              hintText: "Re-enter your password",
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              // Hide password initially
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                if (value != _newPasswordController.text) {
                                  return "Password must be equal to above password";
                                }
                                return null;
                              },
                            ),
                          ),

                          /// 🔹 update Button
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Proceed with login
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
                                "Update Password",
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
      ),
    );
  }
}
