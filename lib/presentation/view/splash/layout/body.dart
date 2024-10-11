import 'dart:async';
import 'package:fin_track/presentation/elements/custom_text.dart';
import 'package:fin_track/presentation/view/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';

import '../../../../configurations/frontend_configs.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnBoardingView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration:const BoxDecoration(
        image:DecorationImage(image: AssetImage("assets/images/splash_bg.png"),
          fit:BoxFit.fill
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            FrontendConfigs.kAppLogo,
            height: 100,
          )),
          CustomText(text: "FinTrack",fontSize:20,fontWeight:FontWeight.w500,color:Colors.white,)
        ],
      ),
    );
  }
}
