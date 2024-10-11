import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/elements/custom_textfield.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/home_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, percentage: 0.5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    text: 'Add your personal info',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                      text:
                          "This info needs to be accurate with your ID document."),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    labelText: "Mr. Riyan ",
                    onTap: () {},
                    keyBoardType: TextInputType.text,
                    label: 'Full Name',
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    labelText: "@username",
                    onTap: () {},
                    keyBoardType: TextInputType.text,
                    label: 'Username',
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    text: "Date of Birth",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 3,
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
                        hintText: "MM/DD/YYYY",
                        hintStyle: TextStyle(
                            color: FrontendConfigs.kAppSecondaryColor,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: FrontendConfigs.kAppSecondaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: FrontendConfigs.kAppPrimaryColor)),
                        prefixIcon: IconButton(
                          icon: SvgPicture.asset("assets/icons/calendar.svg"),
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(

                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (selectedDate != null) {
                              // Handle the selected date
                              print("Selected date: $selectedDate");
                            }
                          },
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AppButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeAddress()));
                  },
                  btnLabel: "Continue",
                  color: FrontendConfigs.kAppSecondaryColor,
                  borderColor: FrontendConfigs.kAppSecondaryColor,
                  textColor: const Color(0xff5A5A5A),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
