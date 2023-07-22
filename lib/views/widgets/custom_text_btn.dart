import 'package:flutter/material.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';

class CustomTextBtn extends StatelessWidget {
  final String btnText;
  final Color textColor;
  final double fontSize;
  final dynamic btnOnPressed;
  const CustomTextBtn(
      {Key? key,
      required this.btnText,
      required this.fontSize,
      required this.textColor,
      required this.btnOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                ColorConstants.backgroundContainerLightColor)),
        onPressed: btnOnPressed,
        child: Text(
          btnText,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w600),
        ));
  }
}
