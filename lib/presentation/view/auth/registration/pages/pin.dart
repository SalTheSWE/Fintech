import 'package:fin_track/configurations/frontend_configs.dart';
import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/country.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class Pin extends StatelessWidget {
   Pin({super.key});
TextEditingController pinController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context, percentage: 0.3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    text: 'Confirm your phone',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(text: "We send 6 digits code to +966 53 031 2216"),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length:6,
                        defaultPinTheme: PinTheme(
                          width: 40,
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: FrontendConfigs.kAppPrimaryColor,
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: FrontendConfigs.kAppSecondaryColor)),
                          ),
                        ),
                        focusedPinTheme:PinTheme(
                          width: 40,
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: FrontendConfigs.kAppPrimaryColor,
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: FrontendConfigs.kAppPrimaryColor,)),
                          ),
                        ) ,
                        submittedPinTheme: PinTheme(
                          width: 40,
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: FrontendConfigs.kAppPrimaryColor,
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: FrontendConfigs.kAppPrimaryColor,)),
                          ),
                        ),
                        validator: (s) {
                          return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                    ],
                  ),
                  const SizedBox(height:28,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      RichText(
                          textAlign:TextAlign.center,
                          text:  TextSpan(
                              text: "Didn’t get a code? ",
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Color(0xff5A5A5A)),
                              children: [
                                TextSpan(
                                  text: "Resend",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: FrontendConfigs.kAppPrimaryColor),),
                              ])),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AppButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Country()));
                  },
                  btnLabel: "Verify Your Number",
                  color: pinController.text.isNotEmpty
                      ? FrontendConfigs.kAppPrimaryColor
                      : FrontendConfigs.kAppSecondaryColor,
                  borderColor: FrontendConfigs.kAppSecondaryColor,
                  textColor: pinController.text.isNotEmpty
                      ? Colors.white
                      : const Color(0xff5A5A5A),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
