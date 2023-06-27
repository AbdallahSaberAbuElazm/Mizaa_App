import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class CenterImageForEmptyData extends StatelessWidget {
  final String imagePath;
  final String text;
  const CenterImageForEmptyData({Key? key, required this.imagePath, required this.text}) : super(key: key);

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
      ),
      Text(
        text,
        style: TextStyle(
            color: ColorConstants.greyColor,
            fontSize: 16,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w500),
      ),]));
  }
}
