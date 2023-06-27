import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:get/get.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
          color: Get.isDarkMode? ColorConstants.darkMainColor: ColorConstants.backgroundContainer,
          child: Center(
            child: Text('Favorite'),
          ),

      ),
    );
  }
}