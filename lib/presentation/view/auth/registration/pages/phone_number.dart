import 'package:country_picker/country_picker.dart';
import 'package:fin_track/configurations/frontend_configs.dart';
import 'package:fin_track/presentation/elements/app_button.dart';
import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../elements/custom_text.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
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
    return Scaffold(
      appBar: customAppBar(context, percentage: 0.2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
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
                      keyboardType: TextInputType.text,
                      obscureText: isSecure,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: FrontendConfigs.kAppSecondaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: FrontendConfigs.kAppSecondaryColor),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset("assets/icons/lock.svg"),
                        ),
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            setState(() {
                              isSecure = !isSecure; // Toggle the secure state
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              isSecure
                                  ? Icons
                                      .visibility // Show this when password is hidden
                                  : Icons.visibility_off,
                              // Show this when password is visible
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AppButton(
                  onPressed: () {
                    _showMyDialog(context);
                  },
                  btnLabel: "Sign up",
                  color: _countryController.text.isNotEmpty
                      ? FrontendConfigs.kAppPrimaryColor
                      : FrontendConfigs.kAppSecondaryColor,
                  borderColor: FrontendConfigs.kAppSecondaryColor,
                  textColor: _countryController.text.isNotEmpty
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

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          titlePadding: EdgeInsets.zero,
          content: Stack(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      "assets/images/group.png",
                      height: 150,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: 'Verify your phone number before we send code',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            textAlign: TextAlign.center,
                            text: "Is this correct?"),
                        CustomText(
                          text: _countryController.text,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: AppButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  Pin()));
                          },
                          btnLabel: "Yes"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: AppButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        btnLabel: "No",
                        color: Colors.white,
                        textColor: FrontendConfigs.kAppPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset("assets/icons/close.svg")),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
