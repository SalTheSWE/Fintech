import 'package:fin_track/presentation/view/auth/registration/registration_view.dart';
import 'package:fin_track/presentation/view/onboarding/onboarding_view.dart';
import 'package:fin_track/presentation/view/splash/splash_view.dart';
import 'package:flutter/material.dart';

import 'presentation/view/auth/login/login_view.dart';
import 'presentation/view/auth/registration/pages/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          fontFamily: "Poppins"),
      home: const SplashView(),
    );
  }
}
