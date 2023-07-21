import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class ContainerFormField extends StatelessWidget {
  final String name;
  final String hintName;
  final TextInputType type;
  final TextEditingController controller;
  final double containerWidth;
  const ContainerFormField(
      {Key? key,
      required this.name,
      required this.hintName,
      required this.type,
      required this.controller,
      required this.containerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: 94,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      padding: const EdgeInsets.only(left: 10, top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          name,
          style: TextStyle(
              color: ColorConstants.greyColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Cairo',
              height: 0.6),
        ),
        SizedBox(
          height: 68,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.black,
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Colors.black,
                focusColor: Colors.black,
                hoverColor: Colors.black,
                hintText: hintName,
                hintStyle: TextStyle(
                  color: ColorConstants.greyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Cairo',
                )),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.left,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please, enter your $name';
              }
            },
          ),
        )
      ]),
    );
  }
}
