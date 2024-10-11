import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final TextEditingController _countryController = TextEditingController();

  bool isPassword = false;

  bool isSecure = false;

  late VoidCallback onTap;

  @override
  void initState() {
    _country = Country(
        phoneCode: "92",
        countryCode: "PK",
        e164Sc: 234,
        geographic: true,
        level: 234,
        name: "name",
        displayName: "Pakistan",
        e164Key: "",
        example: '',
        displayNameNoCountryCode: '');
    super.initState();
  }

  Country? _country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
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
                  text: 'Create an Account',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                    text: "Enter your mobile number to verify your account"),
                const SizedBox(
                  height: 18,
                ),
                CustomText(text: "Phone"),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          showSearch: false,
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: const Color(0xffF3F3F3),
                            textStyle: TextStyle(
                                color: FrontendConfigs.kAppSecondaryColor,
                                fontSize: 14,
                                fontFamily: "Poppins",
                                letterSpacing: 1,
                                fontWeight: FontWeight.w400),
                            bottomSheetHeight: 500,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          onSelect: (Country country) {
                            _country = country;
                            setState(() {});
                            print('Select country: ${country.displayName}');
                          },
                        );
                      },
                      child: Container(
                        height: 48,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: FrontendConfigs.kAppSecondaryColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: _country!.flagEmoji.toString(),
                              fontSize: 22,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "+${_country!.phoneCode}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 48,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _countryController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                hintText: "Mobile number",
                                hintStyle: TextStyle(
                                    color: FrontendConfigs.kAppSecondaryColor,
                                    fontSize: 13,
                                    fontFamily: "Poppins",
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: FrontendConfigs
                                            .kAppSecondaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: FrontendConfigs
                                            .kAppSecondaryColor)),
                                fillColor: Colors.white,
                                filled: true,
                              ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomText(text: "Password"),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                    height: 48,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Mobile number",
                          hintStyle: TextStyle(
                              color: FrontendConfigs.kAppSecondaryColor,
                              fontSize: 13,
                              fontFamily: "Poppins",
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: FrontendConfigs.kAppSecondaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: FrontendConfigs.kAppSecondaryColor)),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset("assets/icons/lock.svg"),
                          ),
                          suffixIcon: isPassword
                              ? InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                setState(() {
                                  isSecure = !isSecure;
                                });
                                return onTap();
                              },
                              child: isSecure
                                  ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: FrontendConfigs
                                        .kAppSecondaryColor,
                                  ))
                                  : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: FrontendConfigs
                                        .kAppSecondaryColor,
                                  )))
                              : null,
                        ))),
                const SizedBox(height:6,),
                CustomText(text: "Forgot password?",fontSize:12,color:FrontendConfigs.kAppPrimaryColor,)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: AppButton(
                onPressed: () {},
                btnLabel: "Log in",
                color: FrontendConfigs.kAppSecondaryColor,
                borderColor: FrontendConfigs.kAppSecondaryColor,
                textColor:const Color(0xff5A5A5A),
              ),
            )
          ],
        ),
      ),
    );
  }
}
