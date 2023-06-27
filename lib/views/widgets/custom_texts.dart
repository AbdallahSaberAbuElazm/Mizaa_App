
import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class CustomTexts{

  static Widget textTitle({required String text}){
    return Text(
        text,
        style: TextStyle(
            color: ColorConstants.black0,
            fontSize: 15,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w600,height: 1.5));
  }

  static Widget textSubTitle({required String text}){
    return Text(
      text,
      style: TextStyle(
        color: ColorConstants.greyColor,
        fontSize: 12,
        fontFamily: 'Noto Kufi Arabic',
      ),
    );
  }

}