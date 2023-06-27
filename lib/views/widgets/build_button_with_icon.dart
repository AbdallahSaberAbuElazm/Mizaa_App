import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class BuildButtonWithIcon extends StatelessWidget {
  final dynamic onPressed;
  final String text;
  final IconData icon;
  const BuildButtonWithIcon({Key? key, required this.onPressed, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.mainColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
            onPressed:onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 26
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.w500),
                ),
              ],
            )));
  }
}
