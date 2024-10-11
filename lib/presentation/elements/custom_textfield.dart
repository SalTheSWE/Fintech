import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configurations/frontend_configs.dart';
import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.isSecure = false,
    this.isPassword = false,
    required this.onTap,
    required this.keyBoardType, required this.label,
  }) : super(key: key);
  final String labelText;
  final String label;
  bool isSecure;
  final TextInputType keyBoardType;

  bool isPassword;
  TextEditingController? controller;
  final VoidCallback onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        CustomText(text: widget.label,fontSize:16,fontWeight:FontWeight.w400,),
        const SizedBox(height:3,),
        SizedBox(
          height: 48,
          child: TextFormField(
            style: const TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Color(0xff414141)),
            keyboardType: widget.keyBoardType,
            controller: widget.controller,
            obscureText: widget.isSecure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 16),
              hintText: widget.labelText,
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
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
