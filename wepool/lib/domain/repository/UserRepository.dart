import 'package:wepool/data/models/LoginResponseDto.dart';
import 'package:wepool/data/models/RegistrationResponseDto.dart';
import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../data/models/VerifyForgetPasswordOtpDto.dart';

abstract class UserRepository {
  Future<RegistrationResponseDto> userRegistration(Map<String, dynamic> userData);
  Future<LoginResponseDto> userLogin(Map<String,dynamic> credentials);
  Future<VerifyOtpDto> verifyOtp(Map<String,dynamic> data);
  Future<VerifyForgetPasswordOtpDto> verifyForgetPasswordOtp(Map<String,dynamic> data);
  Future<VerifyOtpDto> forgetPassword(Map<String,dynamic> data);
  Future<VerifyOtpDto> resetPassword(Map<String,dynamic> data);
}