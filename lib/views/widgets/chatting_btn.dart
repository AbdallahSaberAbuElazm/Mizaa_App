import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class ChattingBtn extends StatelessWidget {
  const ChattingBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: ColorConstants.mainColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.chat_outlined,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
