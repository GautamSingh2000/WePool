import 'package:wepool/data/models/LoginResponseDto.dart';

import '../repository/UserRepository.dart';

class LoginUseCase{
  final UserRepository repository;
  LoginUseCase(this.repository);

  Future<LoginResponseDto> call(Map<String, dynamic> credential) async {
    return await repository.userLogin(credential);
  }
}