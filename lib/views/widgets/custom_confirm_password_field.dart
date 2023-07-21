import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/utils.dart';

class CustomConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final String hintText;
  CustomConfirmPasswordFormField(
      {Key? key,
      required this.controller,
      required this.passwordController,
      required this.hintText})
      : super(key: key);

  @override
  State<CustomConfirmPasswordFormField> createState() =>
      _CustomConfirmPasswordFormFieldState();
}

class _CustomConfirmPasswordFormFieldState
    extends State<CustomConfirmPasswordFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
              fontFamily: 'Noto Kufi Arabic',
              height: 1,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => SizedBox(
              height: 54,
              child: TextFormField(
                scrollPadding: EdgeInsets.zero,
                cursorColor: Colors.black,
                controller: widget.controller,
                validator: (value) {
                  // if (value!.isEmpty) {
                  //   return 'ادخل ${widget.hintText}';
                  // }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: (Controllers.directionalityController
                                  .isPasswordAndConfirmPasswordMatched.value)
                              ? ColorConstants.greyColor
                              : ColorConstants.mainColor,
                          width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: (Controllers.directionalityController
                                  .isPasswordAndConfirmPasswordMatched.value)
                              ? ColorConstants.greyColor
                              : ColorConstants.mainColor,
                          width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      (_passwordVisible == true)
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      size: 22,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  Controllers.directionalityController
                          .isPasswordAndConfirmPasswordMatched.value =
                      widget.controller.text == widget.passwordController.text;
                  print(
                      'matched ${Controllers.directionalityController.isPasswordAndConfirmPasswordMatched.value}');
                },
                obscureText: !_passwordVisible,
                enableSuggestions: false,
                autocorrect: false,
                style: Theme.of(context).textTheme.subtitle1,

                // textAlign: Utils.textAlign,
              )),
        ),
        (widget.controller.text.isNotEmpty && widget.controller.text.length < 4)
            ? Text(
                Utils.getTranslatedText(
                    arText: 'ادخل ${widget.hintText}',
                    enText: 'Please, ${widget.hintText}'),
                style: const TextStyle(
                    color: ColorConstants.mainColor, fontSize: 11))
            : const SizedBox(),
      ],
    );
  }
}
