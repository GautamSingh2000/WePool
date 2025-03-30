import 'package:get_it/get_it.dart';
import 'package:wepool/api/ap_client.dart';
import 'package:wepool/api/api_endpoints.dart';
import 'package:wepool/data/repository/RepositoryImp.dart';
import 'package:wepool/domain/repository/UserRepository.dart';
import 'package:wepool/domain/use_case/LoginUseCase.dart';
import 'package:wepool/domain/use_case/RegistrationUseCase.dart';
import 'package:wepool/domain/use_case/VerifyOtpUseCase.dart';

import 'domain/use_case/ForgetPasswordUseCase.dart';
import 'domain/use_case/ResetPasswordUseCase.dart';
import 'domain/use_case/VerifyForgetPasswordUseCase.dart';

final GetIt locator = GetIt.instance;

void setupDi() {
  // Register API client
  locator.registerLazySingleton(() => ApiClient(ApiEndpoints.baseUrl));

  // Register UserRepository
  locator.registerLazySingleton<UserRepository>(
        () => UserRepositoryImp(locator<ApiClient>()),
  );

  // Register UseCase
  locator.registerLazySingleton(
        () => RegisterUserUseCase(locator<UserRepository>()),
  );

  // Login UseCase
  locator.registerLazySingleton(
        () => LoginUseCase(locator<UserRepository>()),
  );
  // VerifyOtp UseCase
  locator.registerLazySingleton(
        () => VerifyOtpUseCase(locator<UserRepository>()),
  );
  // ForgetPassword UseCase
  locator.registerLazySingleton(
        () => ForgetPasswordUseCase(locator<UserRepository>()),
  );
  // ForgetPasswordOtpVerify UseCase
  locator.registerLazySingleton(
        () => VerifyForgetPasswordOtpUseCase(locator<UserRepository>()),
  );
  // ResetPassword UseCase
  locator.registerLazySingleton(
        () => ResetPasswordUseCase(locator<UserRepository>()),
  );
}
