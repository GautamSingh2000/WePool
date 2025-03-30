import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wepool/data/models/verifyOtpDto.dart';
import 'package:wepool/domain/use_case/VerifyForgetPasswordUseCase.dart';
import 'package:wepool/domain/use_case/VerifyOtpUseCase.dart';

import '../../data/models/RegistrationResponseDto.dart';
import '../../data/models/VerifyForgetPasswordOtpDto.dart';
import '../../domain/use_case/RegistrationUseCase.dart';

class OtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;
  final RegisterUserUseCase registerUserUseCase;
  final VerifyForgetPasswordOtpUseCase verifyForgetPasswordOtpUseCase;

  OtpProvider(this.verifyOtpUseCase,this.registerUserUseCase , this.verifyForgetPasswordOtpUseCase);


  final logger = Logger();

  bool _isLoading = false;
  bool _nextScreen = false;
  String _email = "";
  String _resetToken = "";
  Map<String, String>? _userData;

  String get email => _email;
  String get resetToken => _resetToken;
  bool get isLoading => _isLoading;
  bool get nextScreen => _nextScreen;
  Map<String, String>? get userData => _userData;

  String errorMessage = "";
  VerifyOtpDto? response;
  VerifyForgetPasswordOtpDto? forgetPasswordResponse;
  RegistrationResponseDto? reSendResponse;


  void setUserData(Map<String,String>? userData){
    _userData = userData;
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    errorMessage = "";
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email; // ✅ Correct assignment
    notifyListeners(); // Ensure UI updates
  }


  Future<void> verifyForgetPasswordOtp(String otp) async {
    print(otp);
    if (otp.length < 4) {
      setError("Enter Valid OTP!");
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, String> userData = {"email": _email, "otp": otp};

      forgetPasswordResponse = await verifyForgetPasswordOtpUseCase(userData);
      if (forgetPasswordResponse != null && forgetPasswordResponse?.success == true) {
        _resetToken = forgetPasswordResponse?.resetToken ?? "";
        _isLoading = false;
        _nextScreen = true;
      } else {
        errorMessage = forgetPasswordResponse?.message ?? "OTP verification failed!";
      }
    } catch (e) {
      logger.e("crash while hitting api $e");
      errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reSendOtp() async {
    try {
      _isLoading = true;
      errorMessage = "";
      notifyListeners();

      reSendResponse = await registerUserUseCase(_userData!);

      if (response != null && response?.success == true) {
        _isLoading = false;
      } else {
        SnackBar(
          content: Text("OTP send successfully."),
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      logger.e("crash while hitting api $e");
      errorMessage = "An error occurred while sending OTP: $e";
    } finally {
      _isLoading = false;
      notifyListeners();

    }
  }

  Future<void> verifyOtp(String otp) async {
    print(otp);
    if (otp.length < 4) {
      setError("Enter Valid OTP!");
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, String> userData = {"email": _email, "otp": otp};

      response = await verifyOtpUseCase(userData);
      if (response != null && response?.success == true) {
        _isLoading = false;
        _nextScreen = true;
      } else {
        errorMessage = response?.message ?? "OTP verification failed!";
      }
    } catch (e) {
      logger.e("crash while hitting api $e");
      errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
