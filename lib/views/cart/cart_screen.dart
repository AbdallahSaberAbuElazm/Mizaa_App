import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ecommerce_app/views/widgets/alert_delete.dart';
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:test_ecommerce_app/views/widgets/build_button_with_icon.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';

enum ComingForCart { homPage, offerListCategory, offerDetail }

class CartScreen extends GetView<CartController> {
  final ComingForCart comingForCart;

  const CartScreen({super.key, required this.comingForCart});

  @override
  Widget build(BuildContext context) {
    controller.getCartApi();
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          Controllers.cartController.getCartApi();
          if (comingForCart == ComingForCart.homPage) {
            Get.back();
          } else if (comingForCart == ComingForCart.offerListCategory) {
            Get.back();
          } else {
            Get.back();
            Get.back();
          }

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                controller.appBarCartScreenColor.value,
            flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarIconBrightness:
                  Get.isDarkMode ? Brightness.light : Brightness.dark,
                  statusBarBrightness:
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
                  right: Utils.rightPadding16Right,
                  left: Utils.leftPadding16Left),
              child: GestureDetector(
                onTap: () {
                  Controllers.cartController.getCartApi();
                  if (comingForCart == ComingForCart.homPage) {
                    Get.back();
                  } else if (comingForCart ==
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
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
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
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: 14, left: 14, top: 25),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDelete(
                                  alertText: translation.deleteAllOffer.tr,
                                  onPressedOkBtn: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: ColorConstants.mainColor,
                                            )));
                                    Controllers.cartController.clearCartApi();
                                    // Controllers.cartController.getCartItemsWithoutLoading();
                                    Get.back();
                                    Get.back();
                                  }));
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
                      ))
                  : const SizedBox.shrink()
            ],
          ),
          bottomNavigationBar: (Controllers.cartController.cartItems.isNotEmpty)
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  height: 130,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorConstants.bottomAppBarDarkColor
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {
                            Controllers.cartController.checkedData.value =
                                !Controllers.cartController.checkedData.value;
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 17,
                                height: 17,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2)),
                                    color: Controllers.cartController.checkedData.value
                                        ? ColorConstants.mainColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: Controllers.cartController.checkedData.value
                                          ? ColorConstants.mainColor
                                          : ColorConstants.greyColor,
                                      width: 1,
                                    )),
                                child: (Controllers.cartController.checkedData.value)
                                    ? Center(
                                        child: Icon(
                                        Icons.done,
                                        color: Controllers.cartController
                                                .checkedData.value
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
                              icon: Controllers.directionalityController
                                          .languageBox.value
                                          .read('language') ==
                                      'ar'
                                  ? Icons.keyboard_double_arrow_right
                                  : Icons.keyboard_double_arrow_left,
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
                  ))
              : const SizedBox.shrink(),
          body:
             Controllers.cartController.isLoadingCartItems.value == true
                ? ListView.builder(
                    controller: controller.scrollCartScreenController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, bottom: 5, top: 10),
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
                    ? Obx(() => ListView(
                        padding: const EdgeInsets.all(14),
                        physics: const ScrollPhysics(),
                        controller: controller.scrollCartScreenController,
                        children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  Controllers.cartController.cartItems.length,
                              itemBuilder: (context, index) {
                                // CompanyModel companyModel = CompanyModel.fromJson(Controllers
                                //     .offerController.offerModel.value.company!
                                //     .map((key, value) => MapEntry(key.toString(), value)));
                                return _buildCartItemCard(
                                  cartItemModel:Controllers.cartController.cartItems[index],
                                  context: context,
                                  // offerModel: Controllers
                                  //     .offerController.offerModel.value,
                                  // companyModel: companyModel,
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
                          ]))
                    : _buildCartImageEmpty()
          ),
        ),

    );
  }

  Widget _buildCartItemCard(
      {required CartItemModel cartItemModel, required BuildContext context,
      // required OfferModel offerModel,
      //   required CompanyModel companyModel,
      required int index}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 135,
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
            height: 135,
            child: Stack(
              children: [
                Container(
                    width: 138,
                    height: 135,
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
                                cartItemModel.mainImage.toString()
                            // offerModel.mainImage.toString(),
                            ),
                        fit: BoxFit.cover,
                      ),
                    )),
                Align(
                  alignment: Controllers
                              .directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12))
                          : const BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ApiConstants.storageURL +
                          cartItemModel.companyLogo.toString(),
                      // companyModel.logo.toString(),
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 13,
              ),
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
                                  arText: cartItemModel.companyName,
                                  enText: cartItemModel.enCompanyName,
                                  // companyModel.enName.toString()
                                ),
                                style: TextStyle(
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontSize: 12.5,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.black0),
                              )),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            // width: MediaQuery.of(context).size.width ,
                            height: 38,
                            child: Text(
                              Utils.getTranslatedText(
                                  arText: cartItemModel.arOfferTitle,
                                  // offerModel.arTitle.toString(),
                                  enText: cartItemModel.enOfferTitle),
                              // offerModel.enTitle.toString()),
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
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          // SizedBox(
                          //     width: MediaQuery.of(context).size.width / 8,
                          //     height: 30,
                          //     child: Text(translation.addToFavourite.tr,
                          //         style: TextStyle(
                          //             fontFamily: 'Noto Kufi Arabic',
                          //             fontSize: 8,
                          //             height: 1.5,
                          //             color: ColorConstants.greyColor)))
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
                                    backgroundColor: Get.isDarkMode
                                        ? ColorConstants.bottomAppBarDarkColor
                                        : Colors.white,
                                    // title: Text('Quantity'),
                                    content: Container(
                                      height: 120,
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 16,
                                      ),
                                      color: Get.isDarkMode
                                          ? ColorConstants.bottomAppBarDarkColor
                                          : Colors.white,
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
                                                  Controllers.cartController
                                                      .quantityInCart
                                                      .value = Controllers.cartController
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
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : ColorConstants.black0,
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
                                                  if (Controllers.cartController
                                                      .quantityInCart
                                                      .value > 1) {
                                                    Controllers.cartController
                                                        .quantityInCart
                                                        .value = Controllers.cartController
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
                                                          newQuantity: Controllers.cartController
                                                              .quantityInCart
                                                              .value);
                                                  Controllers.cartController
                                                          .cartItems[index]
                                                          .count
                                                          .value =
                                                      Controllers.cartController
                                                          .quantityInCart.value;
                                                  print(
                                                      'count is ${Controllers.cartController.cartItems[index].count}');
                                                  Controllers.cartController.getCartItemsWithoutLoading();
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
                            Controllers.cartController.cartItems[index].count
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.delete,
                                size: 15.5,
                                color: ColorConstants.redColor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                translation.deleteText.tr,
                                style: TextStyle(
                                    color: ColorConstants.greyColor,
                                    fontSize: 11.6,
                                    height: 1.5),
                              )
                            ],
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDelete(
                                    alertText: translation.deleteOffer.tr,
                                    onPressedOkBtn: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => const Center(
                                              child: CircularProgressIndicator(
                                                color: ColorConstants.mainColor,
                                              )));
                                      Controllers.cartController
                                          .deleteCartItemApi(
                                              cartItemId:
                                                  cartItemModel.id.toString());
                                      Controllers.cartController.getCartItemsWithoutLoading();
                                      Get.back();
                                      Get.back();
                                    }));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
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
        _textSubTitle(text: title),
        _textSubTitle(text: subTitle),
      ],
    );
  }

  Widget _textSubTitle({required String text}) {
    return Text(
      text,
      style: TextStyle(
        color: Get.isDarkMode ? Colors.white : ColorConstants.greyColor,
        fontSize: 12,
        fontFamily: 'Noto Kufi Arabic',
      ),
    );
  }

  Widget _buildTotalRequested(
      {required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _textSubTitle(text: title),
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
          CenterImageForEmptyData(
            imagePath: 'assets/images/cart_empty.png',
            text: translation.cartIsEmpty.tr,
          ),
          // Image.asset(
          //   'assets/images/cart_empty.png',
          //   height: 118,
          //   fit: BoxFit.cover,
          // ),
          // Text(
          //   translation.cartIsEmpty.tr,
          //   style: TextStyle(
          //       color: ColorConstants.greyColor,
          //       fontSize: 16,
          //       fontFamily: 'Noto Kufi Arabic',
          //       fontWeight: FontWeight.w500),
          // ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {
              Controllers.cartController.getCartApi();
              if (comingForCart == ComingForCart.homPage) {
                Get.back();
              } else if (comingForCart ==
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
