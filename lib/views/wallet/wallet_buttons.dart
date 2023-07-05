import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
as translation;

class WalletButtons extends StatefulWidget {

  const WalletButtons({Key? key,})
      : super(key: key);

  @override
  _WalletButtonsState createState() => _WalletButtonsState();
}

class _WalletButtonsState extends State<WalletButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
            btnName: translation.all.tr,
            number: 0, typeOfList: 'all'),
        const SizedBox(
          width: 10,
        ),
        _buildButton(
            btnName: translation.income.tr,
            number: 1, typeOfList: 'income'),
        const SizedBox(
          width: 10,
        ),
        _buildButton(
            btnName: translation.spending.tr,
            number: 2, typeOfList: 'spending'),
      ],
    );


  }

  Widget _buildButton({required String btnName, required int number, required String typeOfList}){
    return  Obx(
          () => SizedBox(
          height: 32,
          child: GestureDetector(
            child: Container(
                padding: const EdgeInsets.only(bottom: 3, left: 18, right: 18),
              decoration: BoxDecoration(
                color:(Controllers.userAuthenticationController.btnName.value ==
                    btnName)
                    ? ColorConstants.mainColor
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ), child: Text(
              btnName,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white
                    : (Controllers.userAuthenticationController.btnName.value ==
                    btnName)
                    ? Colors.white
                    : ColorConstants.greyColor,
                fontSize: 14,
                fontWeight:
                (Controllers.userAuthenticationController.btnName.value ==
                    btnName)
                    ? FontWeight.bold
                    : FontWeight.w400,
                fontFamily: 'Noto Kufi Arabic',
              ),
            ),
            ),

            onTap: () {
              setState(() {
                Controllers.userAuthenticationController.setBtnNameAndNum(
                    name: btnName, number: number);
                if(typeOfList == 'income'){
                  Controllers.userAuthenticationController.getUserIncomeWallet();
                }else if(typeOfList == 'spending'){
                  Controllers.userAuthenticationController.getUserSpendingWallet();
                }
              });
            },

          )),
    );
  }
}
