import 'package:flutter/material.dart';

import 'layout/body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:LogInBody(),
    );
  }
}
