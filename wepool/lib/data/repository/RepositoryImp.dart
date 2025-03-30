import 'dart:async';

import 'package:wepool/data/models/LoginResponseDto.dart';
import 'package:wepool/data/models/RegistrationResponseDto.dart';
import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../api/ap_client.dart';
import '../../api/api_endpoints.dart';
import '../../domain/repository/UserRepository.dart';
import '../models/VerifyForgetPasswordOtpDto.dart';

class UserRepositoryImp implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImp(this.apiClient);

  //for registration
  @override
  Future<RegistrationResponseDto> userRegistration(Map<String, dynamic> userData) async {
    final response = await apiClient.post(ApiEndpoints.registration, userData);
    return RegistrationResponseDto.fromJson(response);
  }

  //for login
  @override
  Future<LoginResponseDto> userLogin(Map<String, dynamic> credentials) async {
    final response = await apiClient.post(ApiEndpoints.login,credentials);
    return LoginResponseDto.fromJson(response);
  }

  //verify otp
  @override
  Future<VerifyOtpDto> verifyOtp(Map<String, dynamic> data) async {
    final response = await apiClient.post(ApiEndpoints.verify_otp,data);
    return VerifyOtpDto.fromJson(response);
  }

  //Forget Password
  @override
  Future<VerifyOtpDto> forgetPassword(Map<String, dynamic> data) async{
    final response = await apiClient.post(ApiEndpoints.forget_password,data);
    return VerifyOtpDto.fromJson(response);
  }

  //verfy otp after forget password
  @override
  Future<VerifyForgetPasswordOtpDto> verifyForgetPasswordOtp(Map<String, dynamic> data) async{
    final response = await apiClient.post(ApiEndpoints.forget_password_otp,data);
    return VerifyForgetPasswordOtpDto.fromJson(response);
  }


  //reset Password
  @override
  Future<VerifyOtpDto> resetPassword(Map<String, dynamic> data) async{
    final response = await apiClient.post(ApiEndpoints.rest_password,data);
    return VerifyOtpDto.fromJson(response);
  }

}

