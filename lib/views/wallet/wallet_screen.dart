import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/models/user/wallet/wallet_history/wallet_history_model.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_ecommerce_app/views/wallet/wallet_buttons.dart';

enum TypeOfMoney { income, spending }

class WalletScreen extends GetView<UserAuthenticationController> {
   WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(Controllers.directionalityController.languageBox.value.read('language'));
    return Obx(() => Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorConstants.bottomAppBarDarkColor
            : ColorConstants.backgroundContainer,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
          // Colors.transparent,
          controller.appBarWalletScreenColor.value,
          elevation: 0,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leadingWidth: double.infinity,
          leading: _buildLeadingAppbar(
            text: translation.wallet.tr,
          ),
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ListView(
            controller: controller.scrollWalletScreenController,
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(context: context),
              _buildIncomeSpendingCard(context: context),
              _buildListOfIncomingSpending(),
            ])));
  }

  Widget _buildLeadingAppbar({required String text}) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: const BoxDecoration(
                color: ColorConstants.mainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style:  TextStyle(
                  color: Get.isDarkMode? Colors.white: controller.appBarItemWalletScreenColor.value,
                  fontSize: 15,
                  fontFamily: 'Noto Kufi Arabic',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required BuildContext context}) {
    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 270,
            color: Get.isDarkMode
                ? ColorConstants.darkMainColor
                : ColorConstants.walletHeaderColor,
          ),

          /////// total balance
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    translation.totalBalance.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Noto Kufi Arabic',
                        height: 1.5),
                  ),
                  Text(
                    '${controller.userWallet.value.balance} ${translation.currencyName.tr}',
                    style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Noto Kufi Arabic',
                        height: 1.5),
                  ),
                ],
              ),
            ),
          ),

          Transform.translate(
            offset: const Offset(0, 2),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 20,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorConstants.bottomAppBarDarkColor
                        : ColorConstants.backgroundContainer,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeSpendingCard({required BuildContext context}) {
    return Transform.translate(
      offset: const Offset(0, -60),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 163,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 7),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildChangedDate(),
            const SizedBox(
              height: 7,
            ),
            _buildIncomeSpendingInfo(),
          ],
        ),
      ),
    );
  }

  // inside _buildIncomeSpendingCard
  Widget _buildChangedDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 31,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
              color: ColorConstants.backgroundContainerLightColor,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Center(
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorConstants.mainColor,
                      size: 17,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      translation.thisWeekText.tr,
                      style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                    ),
                  ]))),
        ),
        Text(
          Utils.getTranslatedText(arText: '1 يناير', enText: '1 January'),
          style: const TextStyle(
            color: ColorConstants.mainColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Kufi Arabic',
          ),
        ),
      ],
    );
  }

  // inside _buildIncomeSpendingCard
  Widget _buildIncomeSpendingInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Obx(() =>  _buildSpendingData(
            text: translation.income.tr,
            price: Controllers.userAuthenticationController.getIncomePrice(),
            icon: Icons.arrow_downward_sharp,
            containerBackground: ColorConstants.incomeBackground)),
      Obx(() =>   _buildSpendingData(
            text: translation.spending.tr,
            price:Controllers.userAuthenticationController.getSpendingPrice(),
            icon: Icons.arrow_upward_sharp,
            containerBackground: ColorConstants.spendingBackground)),
        // const SizedBox(
        //   width: 10,
        // ),
      ],
    );
  }

  // inside _buildIncomeSpendingInfo
  Widget _buildSpendingData(
      {required String text,
      required double price,
      required Color containerBackground,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        children: [
          _buildCircleCardForIncomeSpending(
              containerBackground: containerBackground, icon: icon, width: 48),
          const SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: ColorConstants.mainColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Noto Kufi Arabic',
                    height: 1.5),
              ),
              Text(
                price.toString(),
                style: TextStyle(
                    color: ColorConstants.black0,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto Kufi Arabic',
                    height: 1.7),
              ),
              Text(
                translation.currencyNameForAr.tr,
                style: TextStyle(
                    color: ColorConstants.greyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto Kufi Arabic',
                    height: 1.2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleCardForIncomeSpending(
      {required double width,
      required Color containerBackground,
      required IconData icon}) {
    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerBackground,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  // list of incoming - spending data
  Widget _buildListOfIncomingSpending() {
    List<WalletHistoryModel> walletHistories = (Controllers
                    .userAuthenticationController
                    .userWallet
                    .value
                    .walletHistory ==
                null ||
            controller.userWallet.value
                    .walletHistory ==
                [])
        ? []
        : Controllers
            .userAuthenticationController.userWallet.value.walletHistory
            .map((walletHistory) => WalletHistoryModel.fromJson(walletHistory))
            .toList();


    return Obx (()=>(Controllers
          .userAuthenticationController
          .walletHistories.isNotEmpty)
          ? Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    children: [
                      _drawListSelectBtn(),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: Controllers
                            .userAuthenticationController
                            .walletHistories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 25,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Controllers
                                              .userAuthenticationController
                                              .walletHistories[index].money > 0
                                              ? ColorConstants.incomeBackground
                                              : ColorConstants.spendingBackground,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Center(
                                        child: Text(
                                          '${Controllers
                                              .userAuthenticationController
                                              .walletHistories[index].money} ${translation.currencyName.tr}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      )),
                                  Text(
                                  '${Controllers
                                      .userAuthenticationController
                                      .walletHistories[index].creationDate.day} ${Utils.getMonthName(dateTime: Controllers
                                      .userAuthenticationController
                                      .walletHistories[index].creationDate, )}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstants.greyColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              _buildCalculatedIncomeSpendingCard(
                                  typeOfMoney: Controllers
                                      .userAuthenticationController
                                      .walletHistories[index].money > 0
                                      ? TypeOfMoney.income
                                      : TypeOfMoney.spending,
                                  context: context,
                                  walletHistoryModel: Controllers
                                      .userAuthenticationController
                                      .walletHistories[index])
                            ]),
                          );
                        },
                      ),
                    ],
                  )))
          : CenterImageForEmptyData(
              imagePath: 'assets/images/wallet.png',
              text: translation.noBalance.tr),
    );
  }

  Widget _buildCalculatedIncomeSpendingCard(
      {required TypeOfMoney typeOfMoney,
        required BuildContext context,
      required WalletHistoryModel walletHistoryModel}) {
    return Container(
      height: 91,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          right: Utils.rightPadding16Right,
          left: Utils.leftPadding16Left,
          top: 10,
          bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildCircleCardForIncomeSpending(
                  containerBackground: (typeOfMoney == TypeOfMoney.income)
                      ? ColorConstants.incomeBackground
                      : ColorConstants.spendingBackground,
                  icon: (typeOfMoney == TypeOfMoney.income)
                      ? Icons.arrow_downward_sharp
                      : Icons.arrow_upward_sharp,
                  width: 40),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTexts.textTitle(
                    text: Utils.getTranslatedText(
                        arText: walletHistoryModel.operationArTypeName,
                        enText: walletHistoryModel.operationEnTypeName),
                  ),
                  CustomTexts.textSubTitle(
                      text: Utils.getTranslatedText(
                          arText: walletHistoryModel.opeationArDescription,
                          enText: walletHistoryModel.opeationEnDescription)),
                ],
              ),
            ],
          ),
          Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorConstants.backgroundContainerLightColor,
                borderRadius: BorderRadius.only(
                    topRight: Controllers
                                .directionalityController.languageBox.value
                                .read('language') ==
                            'ar'
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomRight: Controllers
                                .directionalityController.languageBox.value
                                .read('language') ==
                            'ar'
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    topLeft: Controllers.directionalityController.languageBox.value
                                .read('language') ==
                            'ar'
                        ? Radius.circular(0)
                        : Radius.circular(12),
                    bottomLeft:
                        Controllers.directionalityController.languageBox.value.read('language') == 'ar'
                            ? Radius.circular(0)
                            : Radius.circular(12))),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '02:03 PM',
                  style: TextStyle(
                      color: ColorConstants.black0,
                      fontSize: 10,
                      fontFamily: 'Noto Kufi Arabic',
                      height: 1.3,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '${walletHistoryModel.money}${translation.currencyName.tr}',
                  style: TextStyle(
                      color: (typeOfMoney == TypeOfMoney.income)
                          ? ColorConstants.incomeBackground
                          : ColorConstants.spendingBackground,
                      fontSize: 13,
                      fontFamily: 'Noto Kufi Arabic',
                      height: 1.3,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // All - income - spending btn
  Widget _drawListSelectBtn() {
    return const SizedBox(
        height: 38,
        width: double.infinity,
        child:  WalletButtons());
  }
}
