import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/utils.dart';

class BuildIntroText extends StatelessWidget {
  final String headerText;
  const BuildIntroText({Key? key,required this.headerText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Text(headerText, style: Theme.of(context).textTheme.headline1,
    );
  }
}
