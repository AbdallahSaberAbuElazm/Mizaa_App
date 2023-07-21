import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class AlertDelete extends StatelessWidget {
  final String alertText;
  final dynamic onPressedOkBtn;
  const AlertDelete(
      {Key? key, required this.alertText, required this.onPressedOkBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white,
      // title: Text('Quantity'),
      content: Container(
          height: 35,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          color: Get.isDarkMode
              ? ColorConstants.bottomAppBarDarkColor
              : Colors.white,
          child: Text(
            alertText,
            style: TextStyle(
                color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )),
      actions: [
        _textBtn(
            textBtn: translation.deleteText.tr,
            onPressed: onPressedOkBtn,
            textColor: Get.isDarkMode ? Colors.white : ColorConstants.black0),
        _textBtn(
            textBtn: translation.cancelText.tr,
            onPressed: () {
              Get.back();
            },
            textColor: ColorConstants.mainColor),
      ],
    );
  }

  Widget _textBtn(
      {required String textBtn,
      required dynamic onPressed,
      required Color textColor}) {
    return TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                ColorConstants.backgroundContainerLightColor)),
        onPressed: onPressed,
        child: Text(
          textBtn,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ));
  }
}
