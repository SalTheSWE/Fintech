import 'package:fin_track/configurations/frontend_configs.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
  Color? color;
  Color? borderColor;
  Color? textColor;
  double? textSize;
  FontWeight? fontWeight;

  AppButton(
      {super.key,
      required this.onPressed,
      required this.btnLabel,
      this.color,
      this.borderColor,
      this.textSize = 16,
      this.fontWeight = FontWeight.w500,
      this.textColor = Colors.white,
      this.width = double.infinity,
      this.height = 52});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.5,
          backgroundColor: color ?? FrontendConfigs.kAppPrimaryColor,
          side:BorderSide(color:borderColor??FrontendConfigs.kAppPrimaryColor),
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(57),
          )),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnLabel,
            style: TextStyle(
              color: textColor!,
              fontWeight: fontWeight,
              fontFamily: "Poppins",
              fontSize: textSize!,
            ),
          ),
        ],
      ),
    );
  }
}
