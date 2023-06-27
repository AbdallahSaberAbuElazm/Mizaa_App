import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';
import 'package:test_ecommerce_app/views/widgets/build_button_with_icon.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';

enum ComingForCart { homPage, offerListCategory, offerDetail }

class CartScreen extends StatefulWidget {
  final ComingForCart comingForCart;

  const CartScreen({super.key, required this.comingForCart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool checkedData = false;
  @override
  Widget build(BuildContext context) {
    Controllers.cartController.getCartApi();
    Controllers.cartController
        .calculateTotalPrice(Controllers.cartController.cartItems);
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (widget.comingForCart == ComingForCart.homPage) {
            Get.back();
          } else if (widget.comingForCart == ComingForCart.offerListCategory) {
            Get.back();
          } else {
            Get.back();
            Get.back();
          }
          return true;
        },
        child: Scaffold(
          // backgroundColor: ColorConstants.backgroundContainer,
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor:
                // Colors.transparent,
                Controllers.cartController.appBarCartScreenColor.value,
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
                  right: Utils.rightPadding16Right,
                  left: Utils.leftPadding16Left),
              child: GestureDetector(
                onTap: () {
                  if (widget.comingForCart == ComingForCart.homPage) {
                    Get.back();
                  } else if (widget.comingForCart ==
                      ComingForCart.offerListCategory) {
                    Get.back();
                  } else {
                    Get.back();
                    Get.back();
                  }
                },
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
                      translation.cartHeader.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Noto Kufi Arabic',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              (Controllers.cartController.cartItems.isNotEmpty)
                  ?  Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 23),
                  child: GestureDetector(
                    onTap: () {

                        Controllers.cartController.clearCartApi();

                    },
                    child: Text(
                      translation.deleteAllText.tr,
                      style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                    ),
                  )): const SizedBox.shrink()
            ],
          ),
          bottomNavigationBar: (Controllers.cartController.cartItems.isNotEmpty)
              ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          checkedData = !checkedData;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 17,
                            height: 17,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: checkedData
                                    ? ColorConstants.mainColor
                                    : Colors.white,
                                border: Border.all(
                                  color: checkedData
                                      ? ColorConstants.mainColor
                                      : ColorConstants.greyColor,
                                  width: 1,
                                )),
                            child: (checkedData)
                                ? Center(
                                    child: Icon(
                                    Icons.done,
                                    color: checkedData
                                        ? Colors.white
                                        : ColorConstants.mainColor,
                                    size: 15,
                                  ))
                                : const SizedBox(),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            translation.paymentFromWallet.tr,
                            style: const TextStyle(
                              color: ColorConstants.mainColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Noto Kufi Arabic',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: BuildButtonWithIcon(
                          onPressed: () {},
                          icon: Controllers.directionalityController.languageBox.value.read('language') == 'ar'? Icons.keyboard_double_arrow_right : Icons.keyboard_double_arrow_left,
                          text: translation.userLocationScreenBtn.tr,
                        ),
                      ),
                      Container(
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
                      )
                    ],
                  )
                ],
              )): const SizedBox.shrink(),
          body: Obx(() {
            return Controllers.cartController.isLoadingCartItems.value == true
                ? ListView.builder(
                    // controller: Controllers.cartController.scrollCartScreenController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 5, top: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ShimmerContainer(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 129,
                          topPadding: 0,
                          bottomPadding: 0,
                          rightPadding: 0,
                          leftPadding: 0),
                    ),
                  )
                : (Controllers.cartController.cartItems.isNotEmpty)
                    ? ListView(
                        padding: const EdgeInsets.all(16),
                        physics: const ScrollPhysics(),
                        // controller: Controllers.cartController.scrollCartScreenController,
                        children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  Controllers.cartController.cartItems.length,
                              itemBuilder: (context, index) {
                                Controllers.offerController.getOffer(
                                    offerKey: Controllers.cartController
                                        .cartItems[index].offerKey
                                        .toString());
                                return _buildCartItemCard(
                                  cartItemModel: Controllers
                                      .cartController.cartItems[index],
                                  offerModel: Controllers
                                      .offerController.offerModel.value,
                                  index: index,
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 25),
                              child: Divider(
                                color: ColorConstants.greyColor,
                                height: 1,
                              ),
                            ),
                            _buildCheckOutData(),
                          ])
                    : _buildCartImageEmpty();
          }),
        ),
      ),
    );
  }

  Widget _buildCartItemCard(
      {required CartItemModel cartItemModel,
      required OfferModel offerModel,
      required int index}) {
    CompanyModel companyModel = CompanyModel.fromJson(offerModel.company!
        .map((key, value) => MapEntry(key.toString(), value)));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 129,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 138,
            height: 129,
            child: Stack(
              children: [
                Container(
                    width: 138,
                    height: 129,
                    decoration: BoxDecoration(
                      borderRadius: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          ApiConstants.storageURL +
                              offerModel.mainImage.toString(),
                        ),
                        fit: BoxFit.cover,
                      ),
                    )),
                Align(
                  alignment: Controllers
                              .directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: Container(
                    width: 46,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? const BorderRadius.only(
                              bottomRight: Radius.circular(12))
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(12)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ApiConstants.storageURL +
                          companyModel.logo.toString(),
                      width: 23,
                      height: 23,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10, top: 13, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              // height: 25,
                              child: Text(
                                Utils.getTranslatedText(
                                    arText: companyModel.arName.toString(),
                                    enText: companyModel.enName.toString()),
                                style: TextStyle(
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontSize: 13,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.black0),
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 30,
                            child: Text(
                              Utils.getTranslatedText(
                                  arText: offerModel.arTitle.toString(),
                                  enText: offerModel.enTitle.toString()),
                              style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 10,
                                  height: 1.4,
                                  color: ColorConstants.greyColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 19,
                            height: 19,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: ColorConstants
                                    .backgroundContainerLightColor,
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: ColorConstants.mainColor,
                              size: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                              height: 30,
                              child: Text(translation.addToFavourite.tr,
                                  style: TextStyle(
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontSize: 8,
                                      height: 1.5,
                                      color: ColorConstants.greyColor)))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Controllers.cartController.quantityInCart.value =
                            cartItemModel.count.value;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Obx(() => AlertDialog(
                                    // title: Text('Quantity'),
                                    content: Container(
                                      height: 120,
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 16,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .backgroundContainer,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        6),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorConstants
                                                          .mainColor,
                                                      size: 23,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Controllers
                                                      .cartController
                                                      .quantityInCart
                                                      .value = Controllers
                                                      .cartController
                                                      .quantityInCart
                                                      .value +
                                                      1;
                                                  print(
                                                      'quantity is ${Controllers.cartController.quantityInCart.value}');
                                                },
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                Controllers.cartController
                                                    .quantityInCart.value
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        ColorConstants.black0,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .backgroundContainer,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        6),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: ColorConstants
                                                          .mainColor,
                                                      size: 23,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (cartItemModel.count > 1) {
                                                    Controllers
                                                        .cartController
                                                        .quantityInCart
                                                        .value = Controllers
                                                        .cartController
                                                        .quantityInCart
                                                        .value -
                                                        1;
                                                  }
                                                },
                                              ),

                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: CustomButton(
                                                btnText:
                                                    translation.saveText.tr,
                                                textSize: 15,
                                                textColor: Colors.white,
                                                btnBackgroundColor:
                                                    ColorConstants.mainColor,
                                                btnOnpressed: () {
                                                  Controllers.cartController
                                                      .updateCartItemApi(
                                                          cartItemId:
                                                              cartItemModel.id
                                                                  .toString(),
                                                          newQuantity: Controllers
                                                              .cartController
                                                              .quantityInCart
                                                              .value);
                                                  Controllers
                                                          .cartController
                                                          .cartItems[index]
                                                          .count.value =
                                                      Controllers.cartController
                                                          .quantityInCart.value;
                                                  print('count is ${Controllers
                                                      .cartController
                                                      .cartItems[index]
                                                      .count}');
                                                  Get.back();
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 22,
                            height: 19.25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: ColorConstants.mainColor,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(() => Text(
                                Controllers
                                    .cartController.cartItems[index].count
                                    .toString(),
                                style: TextStyle(
                                    color: ColorConstants.black0,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 22,
                            height: 19.25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.backgroundContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                color: ColorConstants.mainColor,
                                size: 18,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 80,
                            child: IconButton(
                              icon: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 13,
                                    color: ColorConstants.redColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    translation.deleteText.tr,
                                    style: TextStyle(
                                        color: ColorConstants.greyColor,
                                        fontSize: 8,
                                        height: 1.5),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Controllers.cartController.deleteCartItemApi(
                                    cartItemId: cartItemModel.id.toString());
                              },
                            )),
                        Row(
                          children: [
                            Text(
                              translation.priceText.tr,
                              style: TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 7.6,
                                  color: ColorConstants.greyColor),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${cartItemModel.totalPrice} ${translation.currencyName.tr}',
                              style: const TextStyle(
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.mainColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCheckOutData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translation.totalAmount.tr,
            style: TextStyle(
                color: ColorConstants.black0,
                fontSize: 15,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 8,
        ),
        Obx(() => _buildRowText(
            title: translation.totalContents.tr,
            subTitle:
                '${Controllers.cartController.totalCartPrice.value} ${translation.currencyName.tr}')),
        const SizedBox(
          height: 9,
        ),
        // Obx(() =>
        _buildRowText(
            title: translation.administrativeExpenses.tr,
            subTitle: '50 ${translation.currencyName.tr}'),
        // ),
        const SizedBox(
          height: 9,
        ),
        Obx(() => _buildTotalRequested(
            title: translation.totalRequested.tr,
            subTitle:
                '${Controllers.cartController.totalCartPrice.value + 50} ${translation.currencyName.tr}')),
        const SizedBox(
          height: 9,
        ),
      ],
    );
  }

  Widget _buildRowText({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTexts.textSubTitle(text: title),
        CustomTexts.textSubTitle(text: subTitle),
      ],
    );
  }

  Widget _buildTotalRequested(
      {required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTexts.textSubTitle(text: title),
        Text(
          subTitle,
          style: const TextStyle(
            color: ColorConstants.mainColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto Kufi Arabic',
          ),
        )
      ],
    );
  }

  // when search text is empty
  Widget _buildCartImageEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cart_empty.png',
            height: 118,
            fit: BoxFit.cover,
          ),
          Text(
            translation.cartIsEmpty.tr,
            style: TextStyle(
                color: ColorConstants.greyColor,
                fontSize: 16,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {
              if (widget.comingForCart == ComingForCart.homPage) {
                Get.back();
              } else if (widget.comingForCart ==
                  ComingForCart.offerListCategory) {
                Get.back();
              } else {
                Get.back();
                Get.back();
              }
            },
            child: Text(translation.browseOffers.tr,
                style: const TextStyle(
                    color: ColorConstants.mainColor,
                    fontSize: 20,
                    height: 1.6,
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
