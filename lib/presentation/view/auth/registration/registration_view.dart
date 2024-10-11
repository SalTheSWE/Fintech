
import 'package:flutter/material.dart';

import 'pages/add_email.dart';
import 'pages/country.dart';
import 'pages/home_address.dart';
import 'pages/personal_info.dart';
import 'pages/phone_number.dart';
import 'pages/pin.dart';
import 'pages/start.dart';
import 'pages/welcome.dart';


class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: CreateAccountBody(),
    );
  }
}
