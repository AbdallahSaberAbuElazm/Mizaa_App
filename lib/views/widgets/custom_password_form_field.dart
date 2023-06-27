import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  CustomPasswordFormField(
      {Key? key, required this.controller, required this.hintText})
      : super(key: key);

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _validatePassword(String password) {
    if (password.length < 4) {
      setState(() {
        Controllers.userAuthenticationController.passwordErrorText.value = SharedPreferencesClass.getLanguageCode() == 'ar'
            ? 'يجب أن تكون كلمة المرور على الأقل 4 أحرف'
            : 'Password must be at least 4 characters long.';
      });
    } else {
      setState(() {
        Controllers.userAuthenticationController.passwordErrorText.value = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.hintText,
            style: TextStyle(
                fontSize: 18,
                color: Get.isDarkMode? Colors.white: ColorConstants.black0,
                fontFamily: 'Noto Kufi Arabic',
                height: 1),
            ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 54,
          child: TextFormField(
            scrollPadding: EdgeInsets.zero,
            cursorColor: Colors.black,
            controller: widget.controller,
            validator: (value) {
              if (value!.length < 4) {
                return SharedPreferencesClass.getLanguageCode() == 'ar'
                    ? 'يجب أن تكون كلمة المرور على الأقل 4 أحرف'
                    : 'Password must be at least 4 characters long.';
              }
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.black,
              focusColor: Colors.black,
              hoverColor: Colors.black,
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorConstants.greyColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorConstants.greyColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              // errorText: _passwordErrorText,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.subtitle2,
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  (_passwordVisible == true)
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color:Get.isDarkMode? Colors.white: Colors.black, size: 22,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            onChanged: _validatePassword,
            obscureText: !_passwordVisible,
            enableSuggestions: false,
            autocorrect: false,
            style: Theme.of(context).textTheme.subtitle1,
            // textAlign: Utils.textAlign,
          ),
        ),
        (widget.controller.text.isNotEmpty && widget.controller.text.length < 4)
            ? Text(
          Controllers.userAuthenticationController.passwordErrorText.value,
                style: const TextStyle(
                    color: ColorConstants.mainColor, fontSize: 11),
              )
            : const SizedBox(),
      ])
    ;
  }
}
