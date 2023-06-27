import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class IconSearch extends StatelessWidget {
  final dynamic searchOnPressed;
  const IconSearch({Key? key, required this.searchOnPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: searchOnPressed,
          child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.backgroundContainerLightColor,
              ),
              child: Icon(
                Icons.search_rounded,
                color: ColorConstants.black0,
              )),
        )
      ],
    );
  }
}
