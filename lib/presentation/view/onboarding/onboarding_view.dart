import 'package:fin_track/presentation/elements/app_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../configurations/frontend_configs.dart';
import '../../elements/custom_text.dart';
import '../auth/registration/registration_view.dart';
import 'layout/pages.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List<SliderPage> _pageList = [
    const SliderPage(
      svg: 'assets/images/trust.png',
      title: 'Trusted by millions of people, part of one part',
    ),
    const SliderPage(
      svg: 'assets/images/money.png',
      title: 'Spend money abroad, and track your expense',
    ),
    const SliderPage(
      svg: 'assets/images/gpt.png',
      title: 'Get advice from FinTrck GPT ',
    ),
  ];
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 80,
            child: PageView.builder(
              controller: controller,
              physics: const ScrollPhysics(),
              onPageChanged: (val) {
                pageIndex = val;
                setState(() {});
              },
              itemCount: _pageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, i) {
                return _pageList[i];
              },
            ),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // height: 60,
                      child: SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: ExpandingDotsEffect(
                              dotHeight: 9,
                              dotWidth: 10,
                              dotColor: const Color(0xffD1D5DB),
                              activeDotColor:
                                  FrontendConfigs.kAppPrimaryColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                    onPressed: () {
                      if (pageIndex == 0) {
                        controller.jumpToPage(1);
                      } else if (pageIndex == 1) {
                        controller.jumpToPage(2);
                      } else if (pageIndex == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccountView()));
                      }
                      setState(() {});
                    },
                    btnLabel: "Next"),
                const SizedBox(
                  height: 38,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
