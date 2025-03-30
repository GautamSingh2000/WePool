import 'package:wepool/data/models/verifyOtpDto.dart';

import '../../data/models/RegistrationResponseDto.dart';
import '../repository/UserRepository.dart';

class ResetPasswordUseCase {
  final UserRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<VerifyOtpDto> call(Map<String, dynamic> data) async {
    return await repository.resetPassword(data);
  }
}