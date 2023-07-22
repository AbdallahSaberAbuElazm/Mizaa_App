import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/models/cart/validate_order_data/order_data_model.dart';
import 'package:mizaa/models/order/order_model.dart';
import 'package:mizaa/providers/order_provider.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/home/HomePage.dart';
import 'package:mizaa/views/home/tabs/order_tab.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;

class OrderController extends GetxController {
  final OrderProvider orderProvider;
  OrderController(this.orderProvider);

  // app bar for merchant detail screen
  late ScrollController scrollOrderTabController;
  final isScrolledOrderTab = false.obs;
  final appBarOrderTabColor = Colors.transparent.obs;
  final appBarItemContainerOrderTabColor = Colors.white.obs;
  final appBarItemOrderTabColor = ColorConstants.mainColor.obs;

  var isLoadingUserOrders = true.obs;
  final userOrders = <OrderModel>[].obs;

  @override
  void onInit() async {
    scrollOrderTabController = ScrollController()
      ..addListener(_onScrollOrderTab);
    super.onInit();
  }

  void _onScrollOrderTab() {
    if (scrollOrderTabController.offset > 20 && !isScrolledOrderTab.value) {
      isScrolledOrderTab.value = true;
      appBarOrderTabColor.value = Colors.white;
      appBarItemContainerOrderTabColor.value = ColorConstants.mainColor;
      appBarItemOrderTabColor.value = Colors.white;
    } else if (scrollOrderTabController.offset <= 20 &&
        isScrolledOrderTab.value) {
      isScrolledOrderTab.value = false;
      appBarOrderTabColor.value = Colors.transparent;
      appBarItemContainerOrderTabColor.value = Colors.white;
      appBarItemOrderTabColor.value = ColorConstants.mainColor;
    }
  }

  validateOrderData(
      {required OrderDataModel orderDataModel,
      required ComingForCart comingForCart,
      required BuildContext context}) {
    orderProvider
        .validateOrderData(orderDataModel: orderDataModel)
        .then((value) {
      if (value != 'Error') {
        makeOrder(
            orderKey: value, comingForCart: comingForCart, context: context);
      }
    });
  }

  makeOrder(
      {required String orderKey,
      required ComingForCart comingForCart,
      required BuildContext context}) {
    orderProvider.makeOrder(orderKey: orderKey).then((value) {
      if (value == 'done') {
        Controllers.cartController.clearCartApi();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  height: 233,
                  color: Get.isDarkMode
                      ? ColorConstants.bottomAppBarDarkColor
                      : Colors.white,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        translation.addToOrderMsg.tr,
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : ColorConstants.black0,
                            fontSize: 13,
                            height: 1.8,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        height: 45,
                        child: CustomButton(
                            btnText: translation.browseOffers.tr,
                            textSize: 15,
                            textColor: Get.isDarkMode
                                ? ColorConstants.bottomAppBarDarkColor
                                : Colors.white,
                            btnBackgroundColor: ColorConstants.mainColor,
                            btnOnpressed: () {
                              Get.back();
                              if (comingForCart == ComingForCart.homPage) {
                                Get.back();
                              } else if (comingForCart ==
                                  ComingForCart.offerListCategory) {
                                Get.back();
                              } else {
                                Get.back();
                                Get.back();
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                ColorConstants.backgroundContainerLightColor)),
                        onPressed: () {
                          Get.back();
                          if (comingForCart == ComingForCart.homPage) {
                            Get.back();
                          } else if (comingForCart ==
                              ComingForCart.offerListCategory) {
                            Get.back();
                          } else {
                            Get.back();
                            Get.back();
                            Get.back();
                          }
                          getUserOrders();
                          Get.to(() => HomePage(
                              recentPage: const OrderTab(), selectedIndex: 1));
                        },
                        child: Text(translation.backToOrder.tr,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : ColorConstants.greyColor,
                                fontSize: 15,
                                height: 1.6,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              );
            });
      } else {
        print('error make order');
      }
    });
  }

  getUserOrders() {
    isLoadingUserOrders.value = true;
    orderProvider.getUserOrders().then((value) {
      userOrders.value = value;
      isLoadingUserOrders.value = false;
    });
  }

  int getOrderNumberOfOffers({required List<Map<String, dynamic>> list}) {
    int orderDetailsListLength = 0;
    for (var order in list) {
      List orderDetails = order["orderDetails"];
      orderDetailsListLength += orderDetails.length;
    }
    return orderDetailsListLength;
  }
}
