import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class SortedByIcon extends StatelessWidget {
  final dynamic sortedByOnPressed;
  const SortedByIcon({
    Key? key,
    required this.sortedByOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sortedByOnPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Get.isDarkMode
              ? ColorConstants.bottomAppBarDarkColor
              : ColorConstants.backgroundContainerLightColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.event_note,
                  color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  translation.sortBy.tr,
                  style: TextStyle(
                      color: Get.isDarkMode
                          ? Colors.white
                          : ColorConstants.greyColor,
                      fontSize: 13),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 18,
              color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
            ),
          ],
        ),
      ),
    );
  }
}
