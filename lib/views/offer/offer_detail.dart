import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/controllers/companies/company_binding.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/models/cart/cart_item_model/cart_item_model.dart';
import 'package:test_ecommerce_app/models/cart/cart_model/cart_model.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/offers/offer_options/OfferOptions.dart';
import 'package:test_ecommerce_app/providers/company_provider.dart';
import 'package:test_ecommerce_app/repositories/company_repository.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/offers/offer_images/OfferImages.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/views/cart/cart_screen.dart';
import 'package:test_ecommerce_app/views/merchant/merchant_branches.dart';
import 'package:test_ecommerce_app/views/merchant/merchant_detail.dart';
import 'package:test_ecommerce_app/views/merchant/merchant_ratings.dart';
import 'package:test_ecommerce_app/views/offer/offer_terms_conditions.dart';
import 'package:test_ecommerce_app/views/offer/widget/expanded_card.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:test_ecommerce_app/views/widgets/build_button_with_icon.dart';
import 'package:test_ecommerce_app/views/widgets/custom_text_line_through.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/views/widgets/custom_indicator_carousel.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class OfferDetail extends GetView<OfferController> {
  final OfferModel offerModel;
  OfferDetail({Key? key, required this.offerModel}) : super(key: key);

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  // final OfferController offerController = Get.find();

  late CompanyModel companyModel = CompanyModel.fromJson(offerModel.company!.map((key, value) => MapEntry(key.toString(), value)));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDarkMode = Get.isDarkMode;
    controller.cartItemsOfferDetail.clear();

    List<OfferImages> offerImages = offerModel.offerImages!
        .map((offerImage) => OfferImages.fromJson(offerImage as Map<String,dynamic>))
        .toList();
    return Obx(
      () => WillPopScope(
        onWillPop: ()async{
          Controllers.offerController.cartItemsOfferDetail.clear();
          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: controller.appBarOfferDescriptionColor.value,
              elevation: 0,
              toolbarHeight: 80,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              leadingWidth: 70,
              leading: GestureDetector(
                onTap: () {
                  Controllers.offerController.cartItemsOfferDetail.clear();
                  Get.back();},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 37,
                    height: 37,
                    // margin: const EdgeInsets.only(left: 16,right: 16),
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
                ),
              ),
              actions: [
                const SizedBox(
                  width: 16,
                ),
                appBarIcon(
                  onTap: (){},
                    icon: Icons.share,
                    iconColor: controller.appBarItemOfferDescriptionColor.value,
                    containerColor: controller
                        .appBarItemContainerOfferDescriptionColor.value),
                const SizedBox(
                  width: 8,
                ),
                appBarIcon(
                  onTap: (){
                    Controllers.offerController.cartItemsOfferDetail.clear();
                      Get.put(CartController(Get.find()));
                      Get.to(()=>const CartScreen(comingForCart: ComingForCart.offerDetail,),);
                  },
                    icon: Icons.shopping_cart_rounded,
                    iconColor: controller.appBarItemOfferDescriptionColor.value,
                    containerColor: controller
                        .appBarItemContainerOfferDescriptionColor.value),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                height: 110,
                decoration:  BoxDecoration(
                  color: Get.isDarkMode? ColorConstants.bottomAppBarDarkColor:  Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${translation.discountName.tr}  ${offerModel.enDiscount}',
                            style: const TextStyle(
                                color: ColorConstants.mainColor,
                                fontSize: 12,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w600),
                          ),
                          // const SizedBox(width: 20,),
                          Text(
                            ' ${translation.couponText.tr} ${Utils.getDateTime(dateTime: offerModel.expireDate!)}',
                            style: const TextStyle(
                                color: ColorConstants.mainColor,
                                fontSize: 12,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
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
                            onPressed:  () async{
                              int counter = 0;
                              List<CartItemModel> items= [];
                              for(int i=0; i< Controllers.offerController.cartItemsOfferDetail.length; i++){
                                if(Controllers.offerController.cartItemsOfferDetail[i].count >0) {
                                  Controllers.offerController.cartItemsOfferDetail[i].totalPrice = Controllers.offerController.cartItemsOfferDetail[i].pricePerItem * Controllers.offerController.cartItemsOfferDetail[i].count.value;
                                  items.add(Controllers.offerController.cartItemsOfferDetail[i]);
                                  counter++;
                                }
                              }

                              if(counter ==0){
                                Utils.snackBar(context: context, msg: translation.addOfferOption.tr, background: ColorConstants.yellowColor,textColor: ColorConstants.black0,);
                              }else{
                                print('items are ${items.map((e) => print('e is ${e.arOfferTitle}'))}');
                                Controllers.cartController.addToCartApi(cartModel: CartModel(cartId: '0', items:items,
                                ));
                                Utils.snackBar(context: context, msg: translation.offerAddedToCart.tr, background: ColorConstants.greenColor, textColor: Colors.white,);
                              }
                            },text: translation.addToCart.tr,icon:  Icons.shopping_cart_rounded
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
                )),
            body: ListView(
                controller: controller.scrollOfferDescriptionController,
                padding: EdgeInsets.zero,
                children: [
                  _buildCarousel(context: context, offerImages: offerImages),
                  Transform.translate(
                    offset: const Offset(0, -45),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(() => CustomIndicatorCarousel(
                              currentBanner: controller.currentBanner.value,
                              list: offerImages,
                            ))),
                  ),
                  _offerDescription(context: context, offer: offerModel, theme: theme),
                ])),
      ),
    );
  }

  Widget _buildCarousel(
      {required BuildContext context, required List<OfferImages> offerImages}) {
    return SizedBox(
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 0.8,
                      initialPage: 0,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      onPageChanged: (index, reason) =>
                          controller.changeBanner(index),
                    ),
                    itemCount: offerImages.length,
                    itemBuilder: (BuildContext contextCarousel, int itemIndex,
                        int pageViewIndex) {
                      if (offerImages.isNotEmpty &&
                          itemIndex < offerImages.length) {
                        return CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          imageUrl: ApiConstants.storageURL +
                              offerImages[itemIndex].imagePath.toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => ShimmerContainer(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            topPadding: 0,
                            bottomPadding: 0,
                            leftPadding: 16,
                            rightPadding: 16,
                          ),
                          // _isLoading(isDarkMode: isDarkMode),
                          // errorWidget: (context, url, error) =>
                          //     _isLoading(isDarkMode: isDarkMode),

                          // background: Image.network(product.image, fit: BoxFit.cover,)
                        );
                      } else {
                        return ShimmerContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          topPadding: 0,
                          bottomPadding: 0,
                          leftPadding: 16,
                          rightPadding: 16,
                        );
                      }
                    })),
            Transform.translate(
              offset: const Offset(0,5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 18,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode? ColorConstants.darkMainColor:  ColorConstants.backgroundContainer,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12))),
                ),
              ),
            ),
          ],
        ));
  }

  Widget appBarIcon(
      {required IconData icon,
      required Color iconColor,
      required Color containerColor,
      required dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: iconColor,
          size: 25,
        ),
      ),
    );
  }

  Widget _offerDescription(
      {required BuildContext context,
      required OfferModel offer,
      required theme}) {

    List<OfferOptions> offerOptions =
        (offer.offerOptions == null || offer.offerOptions == [])
            ? []
            : offer.offerOptions!
                .map((offerOptions) => OfferOptions.fromJson(offerOptions as Map<String,dynamic>))
                .toList();
    return Container(
        color:  Get.isDarkMode? ColorConstants.darkMainColor: ColorConstants.backgroundContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildPriceContainer(
                        height: 36,
                        width: 85,
                        text:
                            '${offer.priceAfterDiscount.toString()} ${translation.discountName.tr}'),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomTextLineThrough(
                        text: offer.priceBeforDiscount.toString(),
                        textColor: ColorConstants.greyColor),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildPriceContainer(
                        height: 36,
                        width: 50,
                        text: '${offer.enDiscount.toString()}%'),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorConstants.backgroundContainerLightColor,
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    color: ColorConstants.mainColor,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MerchantLogo(
                    merchantLogo: companyModel.logo.toString(),
                    containerWidth: 59,
                    containerHeight: 59,
                    logoWidth: 38,
                    logoHeight: 38),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text(
                        Utils.getTranslatedText(arText: offer.arTitle.toString(), enText: offer.enTitle.toString())
                        ,
                        style:  TextStyle(
                          color: Get.isDarkMode? Colors.white: Colors.black,
                          height: 1.3,
                          fontSize: 16,
                          fontFamily: 'Noto Kufi Arabic',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  Utils.getTranslatedText(
                      arText: offer.arSubtitle.toString(),
                      enText: offer.enSubtitle.toString()),
                  style:  TextStyle(
                    color:Get.isDarkMode? Colors.white: Colors.black,
                    height: 1.8,
                    fontSize: 12.5,
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const SizedBox(
              height: 21,
            ),
            Text(
              translation.displayOption.tr,
              style:  TextStyle(
                color:Get.isDarkMode? Colors.white: Colors.black,
                height: 1.3,
                fontSize: 15,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            _buildListOfferOptions(offerOptions: offerOptions),
            const SizedBox(
              height: 16,
            ),
            _buildRatingsListTile(context: context),
            const Divider(
              color: Colors.grey,
            ),
            _buildListTile(
                onPressed: () {
                  Get.to(() => OfferTermsConditions(
                        htmlText: Utils.getTranslatedText(
                            arText: offerModel.arFeatures.toString(),
                            enText: offerModel.enFeatures.toString()),
                      ));
                },
                text: translation.termsConditionsText.tr,
                textColor: ColorConstants.mainColor,
                icon: Icons.info_outline,
                theme: theme),
            const Divider(
              color: Colors.grey,
            ),
            _buildListTile(
                onPressed: () {
                  // Get.put(CompanyRepository());
                  // Get.put(CompanyProvider(Get.find()));
                  // Get.put(CompanyController(Get.find()));
                  // CompanyController(Get.find()).getCompanyBranches(categoryId: offerModel.companyId.toString());
                  Get.to(()=> MerchantBranches(companyKey: offerModel.company!['key'].toString()), binding: CompanyBinding());
                },
                text: translation.branches.tr,
                textColor: Get.isDarkMode? Colors.white:ColorConstants.black0,
                icon: Icons.location_on_outlined,
                theme: theme),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildMerchantCard(
              context: context,
                logoUrl: companyModel.logo.toString(),
                text: translation.merchantsOffers.tr),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _drawOfferOptions({
    required String priceAfterDiscount,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          priceAfterDiscount,
          style: theme.textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }


  ////// price content
  Widget _buildPriceContainer(
      {required String text, required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
        color: ColorConstants.mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            textAlign: TextAlign.center,
          )),
    );
  }

  Widget _buildRatingsListTile({required BuildContext context}) {
    return ListTile(
      onTap: () {
        controller.getOfferRate(offerId: offerModel.id.toString());
        Get.to(()=> const MerchantRatings());
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translation.ratingsText.tr,
            style: TextStyle(
                color:Get.isDarkMode? Colors.white: ColorConstants.black0,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              // Text('(${offerModel.offerRate})'),
              Text(
                '${offerModel.offerRate}',
                style: TextStyle(
                    color:Get.isDarkMode? ColorConstants.mainColor: ColorConstants.black0,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 5,),
              Utils.buildRatings(ratings: offerModel.offerRate?? 0.0, iconSize: 18, unratedColor: Colors.grey),
            ],
          ),
        ],
      ),
      leading: const Icon(
        Icons.star_border_outlined,
        color: ColorConstants.mainColor,
        size: 23,
      ),
      trailing: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: ColorConstants.greyColor,
        size: 18,
      ),
    );
  }

  Widget _buildListTile(
      {required dynamic onPressed,
      required String text,
      required Color textColor,
      required IconData icon,
      required ThemeData theme}) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      leading: Icon(
        icon,
        color: ColorConstants.mainColor,
        size: 23,
      ),
      trailing: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: ColorConstants.greyColor,
        size: 18,
      ),
    );
  }

  Widget _drawRating(
      {required dynamic onPressed,
      required String offerRate,
      required ThemeData theme}) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.star,
            size: 18,
            color: Colors.orange.shade400,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            offerRate,
            style: theme.textTheme.bodyText2!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 13,
            color: Colors.orange.shade400,
          ),
        ],
      ),
    );
  }

  // Widget _drawCounter({required int index}) {
  //   print('lenght of cartitem offer ${Controllers.offerController.cartItemsOfferDetail.length} and index $index');
  //   return  Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //         decoration: BoxDecoration(
  //           color: Colors.transparent,
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         height: 32,
  //         child: Row(
  //           children: [
  //             GestureDetector(
  //                 onTap: () {
  //                   Controllers.offerController.decrementQuantityOfCartItemOfferDetail(index: index);
  //                   print('quantity is ${Controllers.offerController.cartItemsOfferDetail[index].quantity}');
  //
  //                 },
  //                 child: Container(
  //                   width: 23, height: 21,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                     color: ColorConstants.backgroundContainer,
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   child: const Center(
  //                     child: Icon(
  //                       Icons.remove,
  //                       color: ColorConstants.mainColor,
  //                       size: 18,
  //                     ),
  //                   ),
  //                 )),
  //             const SizedBox(
  //               width: 10,
  //             ),
  //             Obx(()=>
  //                 Text(
  //                 '${Controllers.offerController.cartItemsOfferDetail[index].quantity}',
  //                 style: TextStyle(
  //                     color: ColorConstants.black0,
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w600),
  //
  //             )),
  //             const SizedBox(
  //               width: 10,
  //             ),
  //             GestureDetector(
  //                 onTap: () {
  //                   Controllers.offerController.incrementQuantityOfCartItemOfferDetail(index: index);
  //                   print('quantity is ${Controllers.offerController.cartItemsOfferDetail[index].quantity}');
  //                 },
  //                 child: Container(
  //                   width: 23, height: 21,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                     color: ColorConstants.backgroundContainer,
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   child: const Center(
  //                     child: Icon(
  //                       Icons.add,
  //                       color: ColorConstants.mainColor,
  //                       size: 18,
  //                     ),
  //                   ),
  //                 )),
  //           ],
  //         ),
  //   );
  // }
  //
  Widget _buildListOfferOptions({required List<OfferOptions> offerOptions}) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: offerOptions.length,
        itemBuilder: (context, index) {
          Controllers.offerController.cartItemsOfferDetail.add(CartItemModel(arOfferTitle: offerModel.arTitle.toString(),
              enOfferTitle: offerModel.enTitle.toString(), offerId: offerModel.id!,offerKey: offerModel.key.toString(),cartId: 0,offerOptionsId: offerOptions[index].id,
              pricePerItem: offerOptions[index].priceAfterDesc, count: 0.obs, totalPrice: 0));
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ExpandedCard(
              
                index: index,
                title: SharedPreferencesClass.getLanguageCode() == 'ar'
                    ? offerOptions[index].arOfferOptionDesc.toString()
                    : offerOptions[index].enOfferOptionDesc.toString(),
                priceAfter: offerOptions[index].priceAfterDesc.toString(),
                priceBefore: offerOptions[index].priceBeforDesc.toString(),
                discount: offerOptions[index].discount.toString()),
          );
        });
  }

  Widget _buildMerchantCard({
    required String logoUrl,
    required String text,
    required BuildContext context
  }) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        Controllers.searchOfferController.getMerchant(merchantKey: companyModel.key.toString()).then((companyModel) {
          Get.back();
          Get.put(CompanyRepository());
          Get.put(CompanyProvider(Get.find()));
          Get.put(CompanyController(Get.find()));

          Get.to(() => MerchantDetail(companyModel: companyModel,),);
        });
      },
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MerchantLogo(
                    merchantLogo: logoUrl.toString().toString(),
                    containerWidth: 41,
                    containerHeight: 46,
                    logoWidth: 25,
                    logoHeight: 26),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: ColorConstants.black0,
                    fontSize: 16,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_back_ios_new_outlined,
              color: ColorConstants.greyColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
