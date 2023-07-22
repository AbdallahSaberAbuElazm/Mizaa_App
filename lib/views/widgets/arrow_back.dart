import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';

class ArrowBack extends StatelessWidget {
  final dynamic onTap;
  final String text;
  const ArrowBack({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: const BoxDecoration(
              color: ColorConstants.mainColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 15,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
