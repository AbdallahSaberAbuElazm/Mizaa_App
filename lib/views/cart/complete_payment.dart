import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/widgets/arrow_back.dart';
import 'package:get/get.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/chatting_btn.dart';

class CompletePayment extends StatefulWidget {
  CompletePayment({Key? key}) : super(key: key);

  @override
  State<CompletePayment> createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  int selectedIndex = -1;

  List<Map<String, dynamic>> paymentInfo = [
    {
      'paymentName': translation.bankCard.tr,
      'images': [
        'assets/images/meeza.png',
        'assets/images/mastercard.png',
        'assets/images/visa.png'
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarIconBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                  statusBarBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                  systemNavigationBarColor: Get.isDarkMode
                      ? ColorConstants.darkMainColor
                      : Colors.white, // navigation bar color
                  systemNavigationBarIconBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                ),
                child: Container()),
            elevation: 0,
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            leadingWidth: 260,
            leading: Padding(
              padding: EdgeInsets.only(
                  right: Utils.rightPadding12Right,
                  left: Utils.leftPadding12Left),
              child: ArrowBack(
                onTap: () {
                  Get.back();
                },
                text: translation.completePaymentText.tr,
              ),
            )),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: _drawListOfPaymentGateways());
  }

  Widget _drawListOfPaymentGateways() {
    return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: paymentInfo.length,
        itemBuilder: (context, index) => _drawCardPayment(index: index));
  }

  Widget _drawCardPayment({
    required int index,
  }) {
    return Container(
      padding: const EdgeInsets.only(right: 2, left: 12, top: 12, bottom: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<int>(
                value: index,
                activeColor: ColorConstants.mainColor,
                groupValue: selectedIndex,
                onChanged: (int? value) {
                  setState(() {
                    selectedIndex = value ?? -1; // Update the selected index
                  });
                },
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                paymentInfo[index]['paymentName'],
                style: TextStyle(
                  color: ColorConstants.greyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Kufi Arabic',
                ),
              ),
            ],
          ),
          SizedBox(
            width: 99,
            height: 17,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paymentInfo[index]['images'].length,
                itemBuilder: (context, indexImages) => Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Image.asset(
                        paymentInfo[index]['images'][indexImages],
                        width: 27,
                        height: 17,
                        fit: BoxFit.fill,
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
