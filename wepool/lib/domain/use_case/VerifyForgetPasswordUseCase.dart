import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../data/models/RegistrationResponseDto.dart';
import '../../data/models/VerifyForgetPasswordOtpDto.dart';
import '../repository/UserRepository.dart';

class VerifyForgetPasswordOtpUseCase {
  final UserRepository repository;

  VerifyForgetPasswordOtpUseCase(this.repository);

  Future<VerifyForgetPasswordOtpDto> call(Map<String, dynamic> data) async {
    return await repository.verifyForgetPasswordOtp(data);
  }
}