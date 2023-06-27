import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

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
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style:  TextStyle(
                fontSize: 17, color: ColorConstants.black0, fontFamily: 'Noto Kufi Arabic',fontWeight: FontWeight.w500),
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
                    border:  OutlineInputBorder(borderSide: BorderSide(color:ColorConstants.greyColor,width: 1 ),borderRadius: const BorderRadius.all(Radius.circular(12))),
                    isDense: true,
                    focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color:ColorConstants.greyColor,width: 1 ),borderRadius: const BorderRadius.all(Radius.circular(12))),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    hintText: SharedPreferencesClass.getLanguageCode() == 'ar'
                        ? 'ادخل ${widget.name}':'Please, ${widget.name}',
                    hintStyle: Theme.of(context).textTheme.subtitle2),
                style: Theme.of(context).textTheme.subtitle1,
                    // : Theme.of(context).textTheme.subtitle1,
              // textAlign: Utils.textAlign,
                onChanged: (value){
                  // setState(() {
                  //   widget.controller.text = value;
                  // });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return
                      Utils.getTranslatedText(arText:'ادخل ${widget.name}' , enText: 'Please, ${widget.name}')
                      ;
                  }

                  if (widget.name == 'Email' &&
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ))
      // )
        ],

    );
  }
}
