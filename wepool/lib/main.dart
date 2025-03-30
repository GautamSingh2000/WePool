import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';  // ✅ Import Provider
import 'package:wepool/di.dart';
import 'package:wepool/domain/use_case/ForgetPasswordUseCase.dart';
import 'package:wepool/domain/use_case/VerifyForgetPasswordUseCase.dart';
import 'package:wepool/domain/use_case/VerifyOtpUseCase.dart';
import 'package:wepool/presentation/pages/auth/PreSignupScreen.dart';
import 'package:wepool/presentation/pages/auth/SplashScreen.dart';
import 'package:wepool/presentation/provider/ForgetPasswordProvider.dart';
import 'package:wepool/presentation/provider/LoginProvider.dart';
import 'package:wepool/presentation/provider/ReSetPasswordProvider.dart';
import 'package:wepool/presentation/provider/VerifyOtpProvider.dart';
import 'package:wepool/presentation/provider/RegistrationProvider.dart';
import 'package:wepool/services/HiveHelper.dart';
import 'package:wepool/domain/use_case/RegistrationUseCase.dart';

import 'domain/use_case/LoginUseCase.dart';
import 'domain/use_case/ResetPasswordUseCase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveHelper.init();
  setupDi();    // Initialize GetIt dependencies
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegistrationProvider(locator<RegisterUserUseCase>())),
        ChangeNotifierProvider(create: (context) => LoginProvider(locator<LoginUseCase>())),  // ✅ Added New Provider
        ChangeNotifierProvider(create: (context) => OtpProvider(locator<VerifyOtpUseCase>(), locator<RegisterUserUseCase>(), locator<VerifyForgetPasswordOtpUseCase>())),
        ChangeNotifierProvider(create: (context) => ForgetPasswordProvider(locator<ForgetPasswordUseCase>())),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider(locator<ResetPasswordUseCase>())),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}