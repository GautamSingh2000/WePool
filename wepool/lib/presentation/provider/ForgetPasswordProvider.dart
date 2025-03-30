
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wepool/data/models/LoginResponseDto.dart';
import 'package:wepool/data/models/verifyOtpDto.dart';
import 'package:wepool/domain/use_case/ForgetPasswordUseCase.dart';
import 'package:wepool/domain/use_case/LoginUseCase.dart';
import 'package:wepool/services/HiveHelper.dart';
import 'package:wepool/utils/constants.dart';

import '../GlobalScreen.dart';
import '../pages/auth/OtpVerificationScreen.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordProvider(this.forgetPasswordUseCase);

  bool _isLoading = false;
  String _errorMessage = "";
  VerifyOtpDto? response;
  String _email = "";
  String _password = "";
  String _re_password = "";

  // Getters
  String get email => _email;
  String get password => _password;
  String get re_password => _re_password;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void clearError() {
    _errorMessage = "";
    notifyListeners();
  }

  // Setters
  void setEmail(String email) {
    _email = email;
    notifyListeners(); // Notify UI
  }

  Future<void> getOtp( BuildContext context) async {
    print("API Call Started");
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      Map<String,String> credential ={
        "email": _email, // Adding email to the map
      };

      response = await forgetPasswordUseCase(credential);
      print("API Response: ${response?.success}");

      if (response?.success == true) {
        _errorMessage = "";
        _isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpVerificationScreen(
                      email: _email, purpose: "ForgetPasswordOtpVerification"),
            ),
          );
        });
      } else {
        _errorMessage = response?.message ?? "Error to send OTP";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      print("API Call Failed: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}