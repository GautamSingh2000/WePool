import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../data/models/RegistrationResponseDto.dart';
import '../repository/UserRepository.dart';

class VerifyOtpUseCase {
  final UserRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<VerifyOtpDto> call(Map<String, dynamic> data) async {
    return await repository.verifyOtp(data);
  }
}