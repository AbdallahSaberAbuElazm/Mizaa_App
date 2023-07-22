import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';

class FilterationIcon extends StatelessWidget {
  final dynamic filterOnPressed;
  const FilterationIcon({Key? key, required this.filterOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: filterOnPressed,
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Get.isDarkMode
                  ? ColorConstants.bottomAppBarDarkColor
                  : ColorConstants.backgroundContainerLightColor,
            ),
            child: Image.asset(
              'assets/images/filter.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
              color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
            ),
          ),
        )
      ],
    );
  }
}
