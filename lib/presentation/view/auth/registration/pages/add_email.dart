import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class AddEmail extends StatelessWidget {
  const AddEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context, percentage: 0.7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    text: 'Add your email',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                      text: "This info needs to be accurate with your ID document."),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: 48,
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Color(0xff414141)),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: "name@example.com",
                        hintStyle:  TextStyle(
                            color: FrontendConfigs.kAppSecondaryColor,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:  BorderSide(color: FrontendConfigs.kAppSecondaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: FrontendConfigs.kAppPrimaryColor)),
                        prefixIcon:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AppButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Welcome()));
                  },
                  btnLabel: "Continue",
                  color: FrontendConfigs.kAppSecondaryColor,
                  borderColor: FrontendConfigs.kAppSecondaryColor,
                  textColor:const Color(0xff5A5A5A),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
