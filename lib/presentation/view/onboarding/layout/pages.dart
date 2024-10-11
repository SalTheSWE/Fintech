import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../configurations/frontend_configs.dart';
import '../../../elements/custom_text.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({
    Key? key,
    required this.svg,
    required this.title,
  }) : super(key: key);
  final String svg;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            svg,
            height:260,
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,right:16),
            child: CustomText(
              textAlign:TextAlign.center,
              text: title,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}
