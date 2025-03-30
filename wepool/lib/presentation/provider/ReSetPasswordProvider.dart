
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wepool/data/models/LoginResponseDto.dart';
import 'package:wepool/data/models/verifyOtpDto.dart';
import 'package:wepool/domain/use_case/LoginUseCase.dart';
import 'package:wepool/services/HiveHelper.dart';
import 'package:wepool/utils/constants.dart';

import '../../domain/use_case/ResetPasswordUseCase.dart';
import '../GlobalScreen.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordProvider(this.resetPasswordUseCase);

  final logger = Logger();

  bool isLoading = false;
  String errorMessage = "";
  VerifyOtpDto? response;
  bool nextScreen = false;

  String _email = "";
  String _password = "";
  String _resetToken = "";

  // Getters
  String get email => _email;
  String get password => _password;

  void clearError() {
    errorMessage = "";
    notifyListeners();
  }

void setResetToken(String  token){
    _resetToken = token;
}

  // Setters
  void setEmailPassword(String email, String password) {
    _email = email;
    _password = password;
    print("data save in provider : $_email $_password");
    notifyListeners(); // Notify UI
  }

  Future<void> resetPassword() async {
    print("API Call Started");
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      Map<String,String> data =  {
        "email": _email,
        "resetToken": _resetToken,
        "newPassword" : _password
      };

      response = await resetPasswordUseCase(data);
      print("API Response: ${response?.success}");

      if (response?.success == true) {
        errorMessage = "";
        isLoading = false;
        nextScreen = true;
        notifyListeners();  // 🔹 Notify the UI that nextScreen has changed
      } else {
        logger.e(response?.message);
        errorMessage = response?.message == "Invalid or expired reset token"
            ? "Please try again later!"
            : response?.message ?? "Error occurred while setting a new password";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
      print("API Call Failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}