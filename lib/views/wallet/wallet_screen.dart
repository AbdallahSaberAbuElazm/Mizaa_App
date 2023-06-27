import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';


enum TypeOfMoney{
  income, spending
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int num = 0;
  String? btnName = translation.all.tr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: ColorConstants.backgroundContainer,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // controller.appBarOfferDescriptionColor.value,
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
            // controller: controller.scrollOfferDescriptionController,
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(context: context),
              _buildIncomeSpendingCard(context: context),
              _buildListOfIncomingSpending(),
            ]));
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
              style: const TextStyle(
                  color: Colors.white,
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
            color: ColorConstants.walletHeaderColor,
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
                    '0.0 ${translation.currencyName.tr}',
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
                    color: ColorConstants.backgroundContainer,
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
        height: 160,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 11),
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
        const Text(
          '07 Jule - 14 Jule',
          style: TextStyle(
            color: ColorConstants.mainColor,
            fontSize: 13,
            fontFamily: 'Noto Kufi Arabic',
          ),
        ),
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
                  child: Row(children: [
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorConstants.mainColor,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      translation.thisWeekText.tr,
                      style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontSize: 10,
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                    ),
                  ]))),
        ),
      ],
    );
  }

  // inside _buildIncomeSpendingCard
  Widget _buildIncomeSpendingInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSpendingData(
            text: translation.spending.tr,
            price: 0.0,
            icon: Icons.arrow_upward_sharp,
            containerBackground: ColorConstants.spendingBackground),
        _buildSpendingData(
            text: translation.income.tr,
            price: 0.0,
            icon: Icons.arrow_downward_sharp,
            containerBackground: ColorConstants.incomeBackground),
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 22),
      child: Row(
        children: [
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
                    height: 1.5),
              ),
              Text(
                translation.currencyNameForAr.tr,
                style: TextStyle(
                    color: ColorConstants.greyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto Kufi Arabic',
                    height: 1.5),
              ),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          _buildCircleCardForIncomeSpending(
              containerBackground: containerBackground, icon: icon, width: 48),
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
    return Transform.translate(
        offset: const Offset(0, -144),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _drawListSelectBtn(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '14 June',
                      style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: ColorConstants.incomeBackground,
                        borderRadius:const BorderRadius.all(Radius.circular(6))
                      ),
                      child: Text(
                        '125 ${translation.currencyName.tr}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return _buildCalculatedIncomeSpendingCard(typeOfMoney: TypeOfMoney.income);
                    }),
              ],
            )));
  }


  Widget _buildCalculatedIncomeSpendingCard({required TypeOfMoney typeOfMoney}) {
    return Container(
      height: 91,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only( right: Utils.rightPadding16Right,
          left: Utils.leftPadding16Left, top: 10, bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildCircleCardForIncomeSpending(
                  containerBackground:
                  (typeOfMoney == TypeOfMoney.income)? ColorConstants.incomeBackground:
                  ColorConstants.spendingBackground,
                  icon:(typeOfMoney == TypeOfMoney.income)?  Icons.arrow_downward_sharp: Icons.arrow_upward_sharp,
                  width: 40),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTexts.textTitle(
                    text: translation.cashbackText.tr,
                  ),
                  CustomTexts.textSubTitle(text: translation.cashbackCoupon.tr),
                ],
              ),
            ],
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: ColorConstants.backgroundContainerLightColor,
                borderRadius: BorderRadius.only(
                    topRight: Controllers
                        .directionalityController.languageBox.value
                        .read('language') ==
                        'ar'
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomRight:Controllers
                        .directionalityController.languageBox.value
                        .read('language') ==
                        'ar'
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    topLeft: Controllers
                        .directionalityController.languageBox.value
                        .read('language') ==
                        'ar'
                        ? Radius.circular(0)
                        : Radius.circular(12),
                    bottomLeft: Controllers
                        .directionalityController.languageBox.value
                        .read('language') ==
                        'ar'
                        ? Radius.circular(0)
                        : Radius.circular(12))),
            padding: const EdgeInsets.only(
                left: 8, right: 8, top: 4, bottom: 4),
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
                  '+100${translation.currencyName.tr}',
                  style:  TextStyle(
                      color:(typeOfMoney == TypeOfMoney.income)? ColorConstants.incomeBackground: ColorConstants.spendingBackground,
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
    return Row(
      children: [
        _drawBtn(
            btnText: translation.all.tr,
            onPressed: () {
              setState(() {
                btnName = translation.all.tr;
                num = 0;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        _drawBtn(
            btnText: translation.income.tr,
            onPressed: () {
              setState(() {
                btnName = translation.income.tr;
                num = 1;
              });
            }),
        const SizedBox(
          width: 10,
        ),
        _drawBtn(
            btnText: translation.spending.tr,
            onPressed: () {
              setState(() {
                btnName = translation.spending.tr;
                num = 2;
              });
            }),
      ],
    );
  }

  // draw btn for select type of displaying profile
  Widget _drawBtn({required String btnText, required dynamic onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: (btnName == btnText)
              ? ColorConstants.mainColor
              : Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding:
              const EdgeInsets.only(top: 3, bottom: 3, left: 18, right: 18)),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: TextStyle(
          color: (btnName == btnText) ? Colors.white : ColorConstants.greyColor,
          fontSize: 14,
          fontWeight: (btnName == btnText) ? FontWeight.bold : FontWeight.w500,
          fontFamily: 'Noto Kufi Arabic',
        ),
      ),
    );
  }
}
