import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(context, percentage: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                Image.asset("assets/images/welcome.png",height:270,),
                const SizedBox(
                  height: 38,
                ),
                CustomText(
                  textAlign:TextAlign.center,
                  text: 'Congratulations! \nWelcome to FinTrack',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                  const SizedBox(
                    height: 8,
                  ),
                CustomText(
                  textAlign:TextAlign.center,
                    text: "We are happy to have you. It’s time to send, receive and track your expense."),
                const SizedBox(
                  height: 18,
                ),
              ],),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AppButton(
                  onPressed: () {},
                  btnLabel: "Continue",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
