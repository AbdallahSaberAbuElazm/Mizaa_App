import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/offers/offer_options/OfferOptions.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/offers/offer_images/OfferImages.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:test_ecommerce_app/views/widgets/custom_text_line_through.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/views/widgets/custom_indicator_carousel.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class OfferDescriptionPage extends GetView<OfferController> {
  final OfferModel offerModel;
  OfferDescriptionPage({Key? key, required this.offerModel}) : super(key: key);

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

  // final OfferController offerController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Get.isDarkMode;
    return _build(
        context: context,
        offer: offerModel,
        theme: theme,
        isDarkMode: isDarkMode);
  }

  Widget _build(
      {required BuildContext context,
      required OfferModel offer,
      required ThemeData theme,
      required bool isDarkMode}) {
    List<OfferImages> offerImages = offerModel.offerImages!
        .map((offerImage) => OfferImages.fromJson(offerImage))
        .toList();
    return Obx(
      () => Scaffold(
          backgroundColor: ColorConstants.backgroundContainer,
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
              onTap: () => Get.back(),
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
                  icon: Icons.share,
                  iconColor: controller.appBarItemOfferDescriptionColor.value,
                  containerColor: controller
                      .appBarItemContainerOfferDescriptionColor.value),
              const SizedBox(
                width: 8,
              ),
              appBarIcon(
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translation.discountName.tr,
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
                        child: _buildAddCartBtn(),
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
                _offerDescription(context: context, offer: offer, theme: theme),
              ])),
    );
  }

  Widget _buildAddCartBtn() {
    return SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.mainColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  translation.addToCart.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.w500),
                ),
              ],
            )));
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
            Align(
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
          ],
        ));
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

  Widget appBarIcon(
      {required IconData icon,
      required Color iconColor,
      required Color containerColor}) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
      child: Icon(
        icon,
        color: iconColor,
        size: 25,
      ),
    );
  }

  Widget _offerDescription(
      {required BuildContext context,
      required OfferModel offer,
      required theme}) {
    CompanyModel companyModel = CompanyModel.fromJson(offer.company!);
    List<OfferOptions> offerOptions =
        (offer.offerOptions == null || offer.offerOptions == [])
            ? []
            : offer.offerOptions!
                .map((offerOptions) => OfferOptions.fromJson(offerOptions))
                .toList();
    return Container(
        color: ColorConstants.backgroundContainer,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildPriceContainer(
                        height: 40,
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
                        height: 40,
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
                        SharedPreferencesClass.getLanguageCode() == 'ar'
                            ? offer.arTitle.toString()
                            : offer.enTitle.toString(),
                        style: const TextStyle(
                          color: Colors.black,
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
                child: Text( Utils.getTranslatedText(arText: offer.arSubtitle.toString(), enText: offer.enSubtitle.toString()),
                  style: const TextStyle(
                    color: Colors.black,
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
              style: const TextStyle(
                color: Colors.black,
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
            _buildListTile(
                onPressed: () {},
                textAr: 'التقييم',
                textEn: 'Evaluation',
                textColor: ColorConstants.black0,
                icon: Icons.star_border_outlined,
                theme: theme),
            const Divider(
              color: Colors.grey,
            ),
            _buildListTile(
                onPressed: () {},
                textAr: 'الشروط والأحكام',
                textEn: 'Terms and Conditions',
                textColor: ColorConstants.mainColor,
                icon: Icons.info_outline,
                theme: theme),
            const Divider(
              color: Colors.grey,
            ),
            _buildListTile(
                onPressed: () {},
                textAr: 'الفروع',
                textEn: 'Branches',
                textColor: ColorConstants.black0,
                icon: Icons.location_on_outlined,
                theme: theme),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildMerchantCard(
                logoUrl: companyModel.logo.toString(),
                text: SharedPreferencesClass.getLanguageCode() == 'ar'
                    ? 'عروض التاجر'
                    : 'Dealer offers'),
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

  Widget _buildListTile(
      {required dynamic onPressed,
      required String textAr,
      required String textEn,
      required Color textColor,
      required IconData icon,
      required ThemeData theme}) {
    return ListTile(
      title: Text(
        SharedPreferencesClass.getLanguageCode() == 'ar' ? textAr : textEn,
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

  Widget _drawCounter() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 32,
        child: Row(
          children: [
            GestureDetector(
                onTap: () => controller.decrement(),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ColorConstants.backgroundContainer,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      color: ColorConstants.mainColor,
                      size: 18,
                    ),
                  ),
                )),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 30,
              height: 30,
              child: TextField(
                controller: controller.quantityController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    border: InputBorder.none,
                    hintText: '1',
                    hintStyle: TextStyle(fontWeight: FontWeight.w700)),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorConstants.black0,
                    fontSize: 13,
                    fontWeight: FontWeight.w800),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            GestureDetector(
                onTap: () => controller.increment(),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorConstants.backgroundContainer,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: ColorConstants.mainColor,
                      size: 18,
                    ),
                  ),
                )),
          ],
        ));
  }

  Widget _buildListOfferOptions({required List<OfferOptions> offerOptions}) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: offerOptions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: expandedCard(
                context: context,
                title: SharedPreferencesClass.getLanguageCode() == 'ar'
                    ? offerOptions[index].arOfferOptionDesc.toString()
                    : offerOptions[index].enOfferOptionDesc.toString(),
                priceAfter: offerOptions[index].priceAfterDesc.toString(),
                priceBefore: offerOptions[index].priceBeforDesc.toString(),
                discount: offerOptions[index].discount.toString()),
          );
        });
  }

  Widget expandedCard({
    required BuildContext context,
    required String title,
    required String priceAfter,
    required String priceBefore,
    required String discount,
  }) {
    return ExpansionTileCard(
      trailing: const Icon(
        Icons.arrow_drop_down,
        color: ColorConstants.mainColor, // Set the desired icon color
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        SharedPreferencesClass.getLanguageCode() == 'ar'
                            ? '$priceAfter جنية'
                            : '$priceAfter EGP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.black0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        priceBefore,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildPriceContainer(
                          height: 30, width: 54, text: '$discount%'),
                    ],
                  ),
                  _drawCounter(),
                ])),
      ],
    );
  }

  Widget _buildMerchantCard({
    required String logoUrl,
    required String text,
  }) {
    return Container(
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
    );
  }
}
