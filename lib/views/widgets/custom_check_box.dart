import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/views/widgets/custom_text_btn.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  CustomCheckBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  String checkedData = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (checkedData != widget.text) {
            checkedData = widget.text;
            Controllers.userAuthenticationController
                .updateIsChecked(isCheckedValue: true);
          } else {
            checkedData = '';
            Controllers.userAuthenticationController
                .updateIsChecked(isCheckedValue: false);
          }
        });
      },
      child: SizedBox(
        width: 120,
        height: 54,
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(
                    color: ColorConstants.mainColor,
                    width: 1,
                  )),
              child: (checkedData == widget.text)
                  ? const Center(
                      child: Icon(
                      Icons.done,
                      color: ColorConstants.mainColor,
                      size: 20,
                    ))
                  : const SizedBox(),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
