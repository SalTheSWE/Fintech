import 'package:fin_track/configurations/frontend_configs.dart';
import 'package:fin_track/presentation/elements/app_button.dart';
import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/elements/custom_text.dart';
import 'package:fin_track/presentation/view/auth/login/login_view.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/phone_number.dart';
import 'package:flutter/material.dart';

class CreateAccountBody extends StatelessWidget {
  const CreateAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context, percentage:0.1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Image.asset("assets/images/create_account.png",height:270,),
              const SizedBox(
                height: 38,
              ),
              CustomText(
                textAlign: TextAlign.center,
                text: "Create your\nFinTrck account",
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 14,
              ),
              CustomText(
                  textAlign: TextAlign.center,
                  text:
                      "FinTech is a powerful App that allows you to easily  track all your transactions."),
              const SizedBox(
                height: 28,
              ),
              AppButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PhoneNumber()));
              }, btnLabel: "Sign up"),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginView()));
                },
                btnLabel: "Log in",
                color: Colors.white,
                textColor: FrontendConfigs.kAppPrimaryColor,
              ),
              const SizedBox(height:28,),
              RichText(
                textAlign:TextAlign.center,
                  text:  TextSpan(
                      text: "By continuing you accept our\n",
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Color(0xff5A5A5A)),
                      children: [
                      TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          decoration:TextDecoration.underline,
                          color: FrontendConfigs.kAppPrimaryColor),),
                        const TextSpan(
                          text: " and ",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Color(0xff5A5A5A)),),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              decoration:TextDecoration.underline,
                              color: FrontendConfigs.kAppPrimaryColor),),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
