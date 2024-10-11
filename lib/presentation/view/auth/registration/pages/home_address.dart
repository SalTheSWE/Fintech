import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/elements/custom_textfield.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/add_email.dart';
import 'package:flutter/material.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class HomeAddress extends StatelessWidget {
  const HomeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context, percentage: 0.6),
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
                    text: 'Home address',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                      text: "This info needs to be accurate with your ID document."),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                      labelText: "King Fhad",
                      onTap: () {},
                      keyBoardType: TextInputType.text,
                      label: "Address Line"),
                  const SizedBox(height:18,),
                  CustomTextField(
                      labelText: "City, State",
                      onTap: () {},
                      keyBoardType: TextInputType.text,
                      label: "City"),
                  const SizedBox(height:18,),
                  CustomTextField(
                      labelText: "Ex: 00000",
                      onTap: () {},
                      keyBoardType: TextInputType.text,
                      label: "Postcode")
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AppButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddEmail()));
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
