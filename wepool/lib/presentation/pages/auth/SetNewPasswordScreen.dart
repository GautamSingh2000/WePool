import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../widgets/global/GlobalOutlinEditText.dart';
import '../../../widgets/global/GlobalRoundedButton.dart';
import '../../provider/ReSetPasswordProvider.dart';
import 'LoginScreen.dart';
import 'SuccessMessageWidget.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String resetToken;
  final String email;

  const SetNewPasswordScreen({
    super.key,
    required this.resetToken,
    required this.email,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void SetNewPassword() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<ResetPasswordProvider>(
          context,
          listen: false,
        ).resetPassword();

        final resetPasswordProvider = Provider.of<ResetPasswordProvider>(
          context,
          listen: false,
        );

        if (resetPasswordProvider.nextScreen) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SuccessMessageWidget(
              title: "Successful",
              message: "Your password has been changed.",
              btnTitle: "Login",
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                  );
                });
              },
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ResetPasswordProvider>(
          builder: (context, resetPasswordProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (resetPasswordProvider.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(resetPasswordProvider.errorMessage),
                    backgroundColor: Colors.red, // Error styling
                    duration: Duration(seconds: 3),
                  ),
                );
                resetPasswordProvider
                    .clearError(); // Clear error message after showing
              }
            });
            return Stack(
              children: [
                SingleChildScrollView(
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
                                if (_formKey.currentState!.validate() && !resetPasswordProvider.isLoading) {
                                  resetPasswordProvider.setResetToken(widget.resetToken,);
                                  resetPasswordProvider.setEmailPassword(widget.email, _newPasswordController.text,);
                                  SetNewPassword();
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

                if (resetPasswordProvider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
