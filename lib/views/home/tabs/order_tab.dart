import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
          color: Get.isDarkMode? ColorConstants.darkMainColor:ColorConstants.backgroundContainer,
          child: Center(
            child: Text('Orders'),
          ),
        ),

    );
  }
}