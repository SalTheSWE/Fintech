import 'package:fin_track/presentation/elements/custom_appbar.dart';
import 'package:fin_track/presentation/view/auth/registration/pages/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../configurations/frontend_configs.dart';
import '../../../../elements/app_button.dart';
import '../../../../elements/custom_text.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  bool isShow = false;
  bool isSaudia = false;
  bool isUS = false;
  bool isSingapore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, percentage:0.4),
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
                    text: 'Country of residence',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                      text: "This info needs to be accurate with your ID document."),
                  const SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: Container(
                      height: 48,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffB8B8B8)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/saudia.png",
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomText(
                                  text: "Saudi Arabia ",
                                  fontSize: 16,
                                )
                              ],
                            ),
                            SvgPicture.asset("assets/icons/arrow_down.svg")
                          ],
                        ),
                      ),
                    ),
                  ),
                  isShow
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 2),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSaudia = true;
                                      isSingapore = false;
                                      isUS = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/saudia.png",
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          CustomText(
                                            text: "Saudi Arabia ",
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                      isSaudia
                                          ? SvgPicture.asset(
                                              "assets/icons/check_icon.svg")
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSaudia = false;
                                      isSingapore = false;
                                      isUS = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/us.png",
                                            height: 25,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          CustomText(
                                            text: "United State",
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                      isUS
                                          ? SvgPicture.asset(
                                              "assets/icons/check_icon.svg")
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSaudia = false;
                                      isSingapore = true;
                                      isUS = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/turkey.png",
                                            height: 25,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          CustomText(
                                            text: "Singapore",
                                            fontSize: 16,
                                          )
                                        ],
                                      ),
                                      isSingapore
                                          ? SvgPicture.asset(
                                              "assets/icons/check_icon.svg")
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AppButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PersonalInfo()));
                  },
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
