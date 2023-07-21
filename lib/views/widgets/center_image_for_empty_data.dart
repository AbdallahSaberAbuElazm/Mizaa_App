import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class CenterImageForEmptyData extends StatelessWidget {
  final String imagePath;
  final String text;
  const CenterImageForEmptyData(
      {Key? key, required this.imagePath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Image.asset(
            imagePath,
            height: 118,
            fit: BoxFit.cover,
            color: Get.isDarkMode
                ? ColorConstants.bottomAppBarDarkColor
                : ColorConstants.lightMainColor,
          ),
          Text(
            text,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : ColorConstants.greyColor,
                fontSize: 14,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.w500),
          ),
        ]));
  }
}
