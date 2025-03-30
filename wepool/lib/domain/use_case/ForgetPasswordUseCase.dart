import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../data/models/RegistrationResponseDto.dart';
import '../repository/UserRepository.dart';

class ForgetPasswordUseCase {
  final UserRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<VerifyOtpDto> call(Map<String, dynamic> data) async {
    return await repository.forgetPassword(data);
  }
}