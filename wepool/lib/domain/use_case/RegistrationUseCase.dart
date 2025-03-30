import '../../data/models/RegistrationResponseDto.dart';
import '../repository/UserRepository.dart';

class RegisterUserUseCase {
  final UserRepository repository;

  RegisterUserUseCase(this.repository);

  Future<RegistrationResponseDto> call(Map<String, dynamic> userData) async {
    return await repository.userRegistration(userData);
  }
}