import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
  final String name;
  final TextInputType type;
  final TextEditingController controller;
  int lines;
  CustomTextFormField(
      {Key? key,
      required this.name,
      required this.type,
      required this.controller,
      required this.lines})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.bold,
              height: 1),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 54,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              scrollPadding: EdgeInsets.zero,
              cursorColor: Colors.black,
              controller: widget.controller,
              maxLines: widget.lines,
              keyboardType: widget.type,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.greyColor, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.greyColor, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  hintText: Controllers
                              .directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? 'ادخل ${widget.name}'
                      : 'Enter, ${widget.name}',
                  hintStyle: Theme.of(context).textTheme.subtitle2),
              style: Theme.of(context).textTheme.subtitle1,
              // : Theme.of(context).textTheme.subtitle1,
              // textAlign: Utils.textAlign,
              onChanged: (value) {},
              validator: (value) {
                // if (value!.isEmpty) {
                //   return '';
                // }
                //
                // if (widget.name == 'Email' || widget.name == 'البريد الإلكتروني' &&
                //     !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                //         .hasMatch(value)) {
                //   return Utils.getTranslatedText(arText: 'يرجى إدخال عنوان بريد إلكتروني صالح', enText: 'Please enter a valid email address');
                // }
                return null;
              },
            )),
        (widget.controller.text.isNotEmpty &&
                (widget.name == 'Email' ||
                    widget.name == 'البريد الإلكتروني') &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(widget.controller.text))
            ? Text(
                Utils.getTranslatedText(
                    arText: 'يرجى إدخال عنوان بريد إلكتروني صالح',
                    enText: 'Please enter a valid email address'),
                style: const TextStyle(
                    color: ColorConstants.mainColor, fontSize: 11),
              )
            : (widget.controller.text.isEmpty)
                ? Text(
                    Utils.getTranslatedText(
                        arText: 'ادخل ${widget.name}',
                        enText: 'Please, ${widget.name}'),
                    style: const TextStyle(
                        color: ColorConstants.mainColor, fontSize: 11))
                : const SizedBox(),
      ],
    );
  }
}
