import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class CustomIndicatorCarousel extends StatelessWidget {
  final List list;
  final int currentBanner;
  const CustomIndicatorCarousel({Key? key,required this.list, required this.currentBanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      // controller.activeCarouselOffers.asMap().entries.map((entry) {
      list.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 24.0,
          height: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color:
              // controller.currentBanner == entry.key
              currentBanner == entry.key
                  ? ColorConstants.mainColor
                  : Colors.white),
        );
      }).toList(),
    );
  }
}
