import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  const ShimmerContainer(
      {Key? key,
      required this.width,
      required this.height,
      required this.topPadding,
      required this.bottomPadding,
      required this.rightPadding,
      required this.leftPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : Colors.grey.shade300,
        // ColorConstants.shimmerBackgroundGrey,
        highlightColor:
            Get.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade100,
        enabled: true,
        period: const Duration(milliseconds: 800),
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(
            horizontal: SharedPreferencesClass.getLanguageCode() == 'ar'
                ? leftPadding
                : rightPadding,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 0.5, color: ColorConstants.shimmerBackgroundGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 0.2),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/logo_shimmer.png',
              width: width - 25,
              // height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
