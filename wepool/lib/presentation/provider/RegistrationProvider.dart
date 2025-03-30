import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:wepool/utils/constants.dart';
import '../../data/models/DeviceInfoModel.dart';
import '../../domain/use_case/RegistrationUseCase.dart';
import '../../data/models/RegistrationResponseDto.dart';
import '../../services/HiveHelper.dart';
import '../GlobalScreen.dart';
import '../pages/auth/OtpVerificationScreen.dart';

class RegistrationProvider extends ChangeNotifier {
  final RegisterUserUseCase registerUserUseCase;

  RegistrationProvider(this.registerUserUseCase);

  final logger = Logger();

  String _email = "";
  String _password = "";
  String _fullName = "";
  String _dob = "";
  String _mobileNumber = "";

  // Getters
  String get email => _email;
  String get password => _password;
  String get fullName => _fullName;
  String get dob => _dob;
  String get mobileNumber => _mobileNumber;

  bool isLoading = false;
  String errorMessage = "";
  RegistrationResponseDto? response;
  bool nextScreen = false;

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    errorMessage = "";
    notifyListeners();
  }


  // Setters
  void setEmailPassword(String email, String password) {
    _email = email;
    _password = password;
    print("data save in provider : $_email $_password");
    notifyListeners(); // Notify UI
  }

  void setUserDetails(String fullName, String dob, String mobileNumber) {
    _fullName = fullName;
    _dob = dob;
    _mobileNumber = mobileNumber;
    print("data save in provider : $_fullName $_dob $_mobileNumber");
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      DeviceInfoModel deviceData = await HiveHelper.getDeviceInfo(); // Fetch before using

      // Create user data map
      Map<String, String> userData = {
        "email": _email,
        "password": _password,
        "fullName": _fullName,
        "dob": _dob,
        "mobileNumber": _mobileNumber,
        "deviceId": deviceData.deviceId,
        "deviceName": deviceData.deviceName,
        "deviceType": deviceData.deviceType
      };

      response = await registerUserUseCase(userData);

      if (response != null && response?.success == true) {
        saveToken(response?.token);
       isLoading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          // Navigate to OTP screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpVerificationScreen(
                    email: _email,
                    userData: userData,
                    route: GlobalScreen(),
                  ),
            ),
          );
        });
      } else {
        errorMessage = response?.message;
      }
    } catch (e) {
      logger.e("crash while hitting api $e");
      errorMessage = "An error occurred: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void saveToken(String? token) async {
   HiveHelper.saveData(AppConstants.TOKEN, token);
  }
}
