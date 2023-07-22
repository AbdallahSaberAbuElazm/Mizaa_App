import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/companies/company_controller.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/offers/search_offer_controller.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/search/search_model.dart';
import 'package:mizaa/providers/company_provider.dart';
import 'package:mizaa/repositories/company_repository.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/merchant/merchant_detail.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/offer/widget/merchant_logo.dart';
import 'package:mizaa/views/widgets/custom_texts.dart';
import 'package:mizaa/views/widgets/center_image_for_empty_data.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';

enum TypeOfSearch {
  globalSearchWithCity,
  offersInMainCategory,
  offersInSubCategory,
  merchant
}

class SearchScreen extends GetView<SearchOfferController> {
  final TypeOfSearch typeOfSearch;
  final int categoryId;
  SearchScreen({Key? key, required this.typeOfSearch, required this.categoryId})
      : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _searchController.text = '';
        controller.searchOffersList.clear();
        controller.merchantsInSearch.clear();
        return true;
      },
      child: Scaffold(
        // backgroundColor: ColorConstants.backgroundContainer,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
              ),
              child: Container()),
          toolbarHeight: 80,
          leadingWidth: 58,
          leading: GestureDetector(
            onTap: () {
              _searchController.text = '';
              controller.searchOffersList.clear();
              controller.merchantsInSearch.clear();
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: 10,
                  left: Utils.leftPadding12Left,
                  right: Utils.rightPadding12Right),
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
          title: _buildSearchTextField(context: context),
        ),

        body: _buildListOfOffers(),
      ),
    );
  }

  // text form field for search icon
  Widget _buildSearchTextField({required BuildContext context}) {
    return Obx(
      () => Container(
          height: 45,
          margin: const EdgeInsets.only(top: 10),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            scrollPadding: EdgeInsets.zero,
            cursorColor: Colors.black,
            controller: _searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.greyColor, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.greyColor, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                fillColor: Colors.black,
                focusColor: Colors.black,
                hoverColor: Colors.black,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: ColorConstants.greyColor,
                  size: 25,
                ),
                suffixIcon: controller.deleteIconShow.value
                    ? GestureDetector(
                        onTap: () {
                          _searchController.text = '';
                          controller.searchOffersList.clear();
                          controller.merchantsInSearch.clear();
                          controller.deleteIconShow.value = false;
                        },
                        child: Container(
                          width: 23,
                          height: 23,
                          margin: const EdgeInsets.all(11),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.lightMainColor),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                hintText: translation.searchHintText.tr,
                hintStyle: TextStyle(
                    color: ColorConstants.greyColor,
                    fontSize: 13,
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.w400)),
            style: Theme.of(context).textTheme.subtitle1,
            onChanged: (value) {
              if (value != '' || value.isNotEmpty) {
                controller.deleteIconShow.value = true;
                if (typeOfSearch == TypeOfSearch.globalSearchWithCity) {
                  controller.getOffersAndSellersInCity(searchKeyWord: value);
                } else if (typeOfSearch == TypeOfSearch.offersInMainCategory) {
                  controller.getOffersInMainCategoryWithCity(
                      mainCatId: categoryId, searchKeyWord: value);
                } else if (typeOfSearch == TypeOfSearch.offersInSubCategory) {
                  controller.getOffersInSubCategoryWithCity(
                      subCatId: categoryId, searchKeyWord: value);
                } else if (typeOfSearch == TypeOfSearch.merchant) {
                  controller.getMerchantsInSearch(searchKeyWord: value);
                }
              } else {
                _searchController.text = '';
                controller.searchOffersList.clear();
                controller.merchantsInSearch.clear();
                controller.deleteIconShow.value = false;
              }
            },
            validator: (value) {},
          )),
    );
  }

  // when search text is empty
  Widget _buildSearchIcon() {
    return CenterImageForEmptyData(
        imagePath: 'assets/images/search_empty.png',
        text: translation.searchIsEmpty.tr);
  }

  // list of offers searched
  Widget _buildListOfOffers() {
    return Obx(() => (typeOfSearch != TypeOfSearch.merchant)
        ? (controller.isLoadingSearchOfferList.value &&
                _searchController.text.isNotEmpty)
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 20),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: ShimmerContainer(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 91,
                        topPadding: 0,
                        bottomPadding: 0,
                        rightPadding: 0,
                        leftPadding: 0),
                  ),
                ),
              )
            : (controller.searchOffersList.isNotEmpty)
                ? ListView.builder(
                    itemCount: controller.searchOffersList.length,
                    padding: const EdgeInsets.only(
                        bottom: 16, top: 20, left: 16, right: 16),
                    itemBuilder: (context, index) {
                      return _buildOfferSearchedCard(
                          searchModel: controller.searchOffersList[index],
                          context: context);
                    })
                : Center(child: _buildSearchIcon())
        : (controller.isLoadingSearchMerchantList.value &&
                _searchController.text.isNotEmpty)
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 20),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: ShimmerContainer(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: 91,
                        topPadding: 0,
                        bottomPadding: 0,
                        rightPadding: 0,
                        leftPadding: 0),
                  ),
                ),
              )
            : (controller.merchantsInSearch.isNotEmpty)
                ? ListView.builder(
                    itemCount: controller.merchantsInSearch.length,
                    padding: const EdgeInsets.only(
                        bottom: 16, top: 20, left: 16, right: 16),
                    itemBuilder: (context, index) {
                      return _buildMerchantSearchedCard(
                          searchModel: controller.merchantsInSearch[index],
                          context: context);
                    })
                : Center(child: _buildSearchIcon()));
  }

  // card for search
  Widget _buildOfferSearchedCard(
      {required SearchModel searchModel, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        print('//////// search in offers');
        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        controller
            .getOffer(offerKey: searchModel.offerKey.toString())
            .then((offer) {
          Get.back();
          Get.put(OfferController(Get.find()));
          Get.to(() => OfferDetail(offerModel: offer));
        });

        // OfferDetail(offerModel: );
      },
      child: Container(
        // height: 91,
        padding: EdgeInsets.only(
            left: Utils.leftPadding12Left,
            right: Utils.rightPadding12Right,
            top: 14,
            bottom: 14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MerchantLogo(
                    merchantLogo: (typeOfSearch == TypeOfSearch.merchant)
                        ? searchModel.companyLogo.toString()
                        : searchModel.offerMainImage.toString().toString(),
                    containerWidth: 60,
                    containerHeight: 55,
                    logoWidth: 33,
                    logoHeight: 33),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // height: 40,
                          child: Text(
                              // (typeOfSearch == TypeOfSearch.merchant)?

                              translation.offerName.trParams({
                                'offerName': Utils.getTranslatedText(
                                    arText:
                                        searchModel.companyArName.toString(),
                                    enText:
                                        searchModel.companyEnName.toString())
                              }),
                              //     :
                              //
                              // translation.offerName.trParams({
                              //   'offerName': Utils.getTranslatedText(
                              //       arText: searchModel.offerArTitle.toString(),
                              //       enText: searchModel.offerEnTitle.toString())
                              // }),
                              style: TextStyle(
                                  color: ColorConstants.black0,
                                  fontSize: 13,
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontWeight: FontWeight.w600,
                                  height: 1.5))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 25,
                          child: CustomTexts.textSubTitle(
                              text: translation.offerName.trParams({
                            'offerName': Utils.getTranslatedText(
                                arText: searchModel.offerArTitle.toString(),
                                enText: searchModel.offerEnTitle.toString())
                          }))),
                    ],
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstants.mainColor,
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
                      topLeft: Controllers.directionalityController.languageBox.value.read('language') == 'ar'
                          ? Radius.circular(0)
                          : Radius.circular(12),
                      bottomLeft: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? Radius.circular(0)
                          : Radius.circular(12))),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              child: Text(
                '${searchModel.offerDiscount}% \n${translation.discountName.tr}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Noto Kufi Arabic',
                    height: 1.3,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // card for search
  Widget _buildMerchantSearchedCard(
      {required MerchantModel searchModel, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        print('merchant key is ${searchModel.key.toString()}');
        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        controller
            .getMerchant(merchantKey: searchModel.key.toString())
            .then((companyModel) {
          Get.back();
          Get.put(CompanyRepository());
          Get.put(CompanyProvider(Get.find()));
          Get.put(CompanyController(Get.find()));

          Get.to(
            () => MerchantDetail(
              companyModel: companyModel,
            ),
          );
        });
      },
      child: Container(
        // height: 91,
        padding: EdgeInsets.only(
            left: Utils.leftPadding12Right,
            right: Utils.rightPadding12Right,
            top: 14,
            bottom: 14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MerchantLogo(
                    merchantLogo: searchModel.logo.toString(),
                    containerWidth: 60,
                    containerHeight: 55,
                    logoWidth: 33,
                    logoHeight: 33),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // height: 40,
                          child: Text(
                              translation.offerName.trParams({
                                'offerName': Utils.getTranslatedText(
                                    arText: searchModel.arname.toString(),
                                    enText: searchModel.enname.toString())
                              }),
                              style: TextStyle(
                                  color: ColorConstants.black0,
                                  fontSize: 13,
                                  fontFamily: 'Noto Kufi Arabic',
                                  fontWeight: FontWeight.w600,
                                  height: 1.5))),
                      Container(
                        height: 22,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: ColorConstants.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          '${searchModel.count} ${translation.offersText.tr}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Noto Kufi Arabic',
                              height: 1.4),
                          // textAlign: TextAlign.center,
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
            Controllers.directionalityController.languageBox.value
                        .read('language') ==
                    'ar'
                ? Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorConstants.greyColor,
                    size: 18,
                  )
                : Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorConstants.greyColor,
                    size: 18,
                  ),
          ],
        ),
      ),
    );
  }
}
