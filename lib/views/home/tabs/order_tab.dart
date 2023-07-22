import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/order/order_controller.dart';
import 'package:mizaa/models/order/order_model.dart';
import 'package:mizaa/models/order/order_offer_detail/order_offer/order_offer_model.dart';
import 'package:mizaa/models/order/order_offer_detail/order_offer_detail/order_offer_detail_model.dart';
import 'package:mizaa/models/order/order_status/order_status_model.dart';
import 'package:mizaa/models/payment_getway/payment_way_model.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';

class OrderTab extends GetView<OrderController> {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUserOrders();
    return Obx(() => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: controller.appBarOrderTabColor.value,
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
            // backgroundColor: Colors.transparent,
            toolbarHeight: 80,
            leadingWidth: 260,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(
                  right: Utils.rightPadding12Right,
                  left: Utils.leftPadding12Left),
              child: Row(children: [
                Text(
                  translation.ordersText.tr,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 15,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: _drawListOfOrders(),
        ));
  }

  Widget _drawListOfOrders() {
    return Obx(
      () => controller.isLoadingUserOrders.value == true
          ? ListView.builder(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ShimmerContainer(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 135,
                    topPadding: 0,
                    bottomPadding: 0,
                    rightPadding: 0,
                    leftPadding: 0),
              ),
            )
          : ListView.builder(
              controller: controller.scrollOrderTabController,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              itemCount: controller.userOrders.length,
              itemBuilder: (context, index) => ExpandedTitleCardOrder(
                    orderModel: controller.userOrders[index],
                  )),
    );
  }
}

class ExpandedTitleCardOrder extends StatefulWidget {
  final OrderModel orderModel;
  const ExpandedTitleCardOrder({Key? key, required this.orderModel})
      : super(key: key);

  @override
  State<ExpandedTitleCardOrder> createState() => _ExpandedTitleCardOrderState();
}

class _ExpandedTitleCardOrderState extends State<ExpandedTitleCardOrder> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final OrderStatusModel orderStatusModel =
        OrderStatusModel.fromJson(widget.orderModel.orderStatus);
    final PaymentWayModel paymentWayModel =
        PaymentWayModel.fromJson(widget.orderModel.paymentWay);

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
          top: 6,
          bottom: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.gray100,
              offset: const Offset(0, 2), // controls the offset of the shadow
              blurRadius: 4, // controls the blur radius of the shadow
              spreadRadius: 0, // controls the spread radius of the shadow
            ),
          ],
        ),
        child: ExpansionTileCard(
            expandedColor: Colors.white,
            baseColor: Colors.white,
            initiallyExpanded: false,
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            contentPadding: EdgeInsets.only(
              right: Utils.rightPadding12Right,
              top: 8,
              bottom: 10,
            ),
            trailing: const SizedBox.shrink(),
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabelInfo(
                                labelName: translation.orderNumber.tr,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildLabelInfo(
                                labelName: translation.paymentMethod.tr,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildLabelDetail(
                                  labelDetail: widget.orderModel.id.toString()),
                              const SizedBox(
                                height: 5,
                              ),
                              _buildLabelDetail(
                                  labelDetail: Utils.getTranslatedText(
                                      arText: paymentWayModel.name,
                                      enText: paymentWayModel.enName)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabelInfo(
                                  labelName: translation.orderDate.tr,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                _buildLabelInfo(
                                  labelName: translation.numberOfOffers.tr,
                                ),
                              ]),
                          const SizedBox(
                            width: 9,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildLabelDetail(
                                    labelDetail: Utils.getDateTime(
                                        dateTime:
                                            widget.orderModel.creationDate)),
                                const SizedBox(
                                  height: 5,
                                ),
                                _buildLabelDetail(
                                    labelDetail: Controllers.orderController
                                        .getOrderNumberOfOffers(
                                            list: widget.orderModel.order)
                                        .toString()),
                              ]),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Row(
                    children: [
                      _buildLabelInfo(
                        labelName: translation.orderStatus.tr,
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      _buildLabelDetail(
                          labelDetail: Utils.getTranslatedText(
                              arText: orderStatusModel.arStatusName,
                              enText: orderStatusModel.enStatusName)),
                    ],
                  ),
                ]),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 14),
              child:
                  // Column(
                  //   children: [
                  // Divider(color: ColorConstants.backgroundContainerLightColor,height: 1.5,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  translation.orderDetails.tr,
                  style: const TextStyle(
                    color: ColorConstants.mainColor,
                    fontSize: 11.5,
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  isExpanded
                      ? Icons.arrow_circle_up_outlined
                      : Icons.arrow_circle_down_outlined,
                  color: ColorConstants.mainColor,
                  size: 23,
                )
              ]),
              //   ],
              // ),
            ),
            children: widget.orderModel.order.map((order) {
              final OrderOfferModel orderOfferModel =
                  OrderOfferModel.fromJson(order);
              final List<OrderOfferDetailModel> orderOfferDetails =
                  orderOfferModel.orderDetails
                      .map((orderDetail) =>
                          OrderOfferDetailModel.fromJson(orderDetail))
                      .toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderOfferDetails.length,
                itemBuilder: (context, index) => _buildOfferOptionCard(
                    orderOfferModel: orderOfferModel,
                    orderOfferDetailModel: orderOfferDetails[index]),
              );
            }).toList()));
  }

  Widget _buildOfferOptionCard(
      {required OrderOfferModel orderOfferModel,
      required OrderOfferDetailModel orderOfferDetailModel}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        Controllers.offerController
            .getOffer(offerKey: orderOfferModel.offerKey.toString())
            .then((offer) {
          Get.back();

          Get.put(OfferController(Get.find())).resetOfferDetailScrolling();
          Controllers.offerController.cartItemsOfferDetail.clear();
          Get.to(() => OfferDetail(offerModel: offer));
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorConstants.gray100, width: 0.4),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.gray100,
              offset: const Offset(0, 0.4), // controls the offset of the shadow
              blurRadius: 0.5, // controls the blur radius of the shadow
              spreadRadius: 0, // controls the spread radius of the shadow
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            ApiConstants.storageURL +
                                orderOfferModel.mainImage.toString()
                            // offerModel.mainImage.toString(),
                            ),
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextForSubTitle(
                          text:
                              '#${widget.orderModel.id.toString()}-${orderOfferDetailModel.id}',
                        ),
                        _buildLabelInfo(
                            labelName: Utils.getTranslatedText(
                                arText: orderOfferModel.companyName,
                                enText: orderOfferModel.enCompanyName)),
                        _buildTextForSubTitle(
                            text: Utils.getTranslatedText(
                                arText: orderOfferDetailModel.arOfferOptionDesc,
                                enText:
                                    orderOfferDetailModel.enOfferOptionDesc)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${orderOfferDetailModel.coboneCount} ${translation.coupon.tr}',
                              style: TextStyle(
                                color: ColorConstants.black0,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Noto Kufi Arabic',
                              ),
                            ),
                            Text(
                              '${orderOfferDetailModel.cobonesCost} ${translation.currencyName.tr}',
                              style: const TextStyle(
                                  color: ColorConstants.mainColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(left: 7,right: 7,top: 4,bottom: 4),
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(6)),
                //     color: ColorConstants.lightMainColor,
                //   ),
                //   child: Text(translation.couponsText.tr,style: const TextStyle(color: ColorConstants.mainColor, fontSize: 10),),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextForSubTitle({required String text}) {
    return Text(
      text,
      style: TextStyle(
        color: ColorConstants.gray200,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        fontFamily: 'Noto Kufi Arabic',
      ),
    );
  }

  Widget _buildLabelInfo({
    required String labelName,
  }) {
    return Text(labelName,
        style: TextStyle(
            color: ColorConstants.black0,
            fontSize: 11,
            fontFamily: 'Noto Kufi Arabic',
            fontWeight: FontWeight.w800,
            height: 1.5));
  }

  Widget _buildLabelDetail({required String labelDetail}) {
    return Text(
      labelDetail,
      style: TextStyle(
        color: ColorConstants.gray200,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        fontFamily: 'Noto Kufi Arabic',
      ),
    );
  }
}
