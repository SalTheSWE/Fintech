import 'package:fin_track/configurations/frontend_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

customAppBar(BuildContext context,{required double percentage,}){
  return AppBar(
    leading:InkWell(
      borderRadius:BorderRadius.circular(14),
      onTap:(){
        Navigator.pop(context);
      },
      child:Padding(
        padding: const EdgeInsets.all(14.0),
        child: SvgPicture.asset("assets/icons/arro.svg"),
      )
      ),
    backgroundColor:Colors.transparent,
    elevation:0,
    centerTitle:true,
    bottom:PreferredSize(preferredSize:Size(MediaQuery.sizeOf(context).width, 0),
        child:LinearPercentIndicator(
          width:MediaQuery.sizeOf(context).width,
          animation: true,
          lineHeight: 4.0,
          animationDuration:1000,
          backgroundColor:const Color(0xffF7F7F7),
          percent:percentage,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: FrontendConfigs.kAppPrimaryColor,
        ),
    ),
  );
}