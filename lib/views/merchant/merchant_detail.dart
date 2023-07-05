import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/models/merchant/merchant_detail_model/merchant_detail_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/offer/OfferCard.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';

class MerchantDetail extends GetView<CompanyController> {
  final MerchantDetailModel companyModel;
  // final OfferModel offerModel;
  const MerchantDetail({
    Key? key,
    required this.companyModel,
    // required this.offerModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.getOffersForCompany(companyId: companyModel.id.toString());
    return Obx(() => Scaffold(
          // backgroundColor: ColorConstants.backgroundContainer,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor: controller.appBarMerchantDetailColor.value,
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
                      )))),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListView(
            physics: const ScrollPhysics(),
            controller: controller.scrollMerchantDetailController,
            padding: EdgeInsets.zero,
            children: [
              _buildCompanyImage(context: context),
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  translation.offerName.trParams({
                    'offerName': Utils.getTranslatedText(
                        arText: '${translation.offersWithoutThe.tr} ${companyModel.arName}',
                        // companyModel.description.toString(),
                        enText: '${translation.offersWithoutThe.tr} ${companyModel.enName}'
                    )
                  }),
                  style: TextStyle(
                      color:Get.isDarkMode? Colors.white:  ColorConstants.black0,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _createListOfOffers(),
            ],
          ),
        ));
  }

  Widget _buildCompanyImage({required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280,
      child: Stack(
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: 280,
            imageUrl:
                ApiConstants.storageURL + companyModel.headerPhoto.toString(),
            fit: BoxFit.cover,
            placeholder: (context, url) => ShimmerContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              topPadding: 0,
              bottomPadding: 0,
              leftPadding: 16,
              rightPadding: 16,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 30),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 103,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 16, bottom: 11),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildCommunicationIConsForMerchant(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomTexts.textTitle(
                                text: translation.offerName.trParams({
                              'offerName': Utils.getTranslatedText(
                                  arText: companyModel.arName.toString(),
                                  enText: companyModel.enName.toString())
                            })),
                          ),
                          //TODO
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomTexts.textSubTitle(
                                  text: translation.offerName.trParams({
                                'offerName': Utils.getTranslatedText(
                                    arText: companyModel.description.toString(),
                                    enText:
                                        companyModel.enDescription.toString())
                              }))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 41, left: 41),
                      child: Transform.translate(
                        offset: const Offset(0, -30),
                        child: MerchantLogo(
                            merchantLogo: companyModel.logo.toString(),
                            containerWidth: 60,
                            containerHeight: 55,
                            logoWidth: 32,
                            logoHeight: 32),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _buildCommunicationIConsForMerchant() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildIcon(imagePath: 'assets/images/location.png', onPressed: () {}),
        const SizedBox(
          width: 6,
        ),
        _buildIcon(imagePath: 'assets/images/call.png', onPressed: () {}),
        const SizedBox(
          width: 6,
        ),
        _buildIcon(imagePath: 'assets/images/facebook.png', onPressed: () {}),
        const SizedBox(
          width: 6,
        ),
        _buildIcon(imagePath: 'assets/images/website.png', onPressed: () {}),
      ],
    );
  }

  Widget _buildIcon({required String imagePath, required dynamic onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        imagePath,
        width: 22,
        height: 21,
        color: ColorConstants.mainColor,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _createListOfOffers() {
    List<OfferModel> offers = companyModel.offers!
        .map((offer) => OfferModel.fromJson(offer))
        .toList();
    return
        // (controller.isLoadingCompanyOffers.value)
        //   ? ListView.builder(
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemCount: 3,
        //       padding: const EdgeInsets.only(top: 20, bottom: 20),
        //       itemBuilder: (context, index) => Padding(
        //         padding: const EdgeInsets.only(
        //           bottom: 16,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 16,
        //           ),
        //           child: ShimmerContainer(
        //               width: MediaQuery.of(context).size.width / 1.5,
        //               height: 204,
        //               topPadding: 0,
        //               bottomPadding: 0,
        //               rightPadding: 0,
        //               leftPadding: 0),
        //         ),
        //       ),
        //     )
        //   : (
        (offers.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 20, top: 20),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return OfferCard(
                      offerModel: offers[index],
                      width: MediaQuery.of(context).size.width,
                      height: 248);
                },
              )
            :  Center(
                child: Text(
                  translation.noDataYet.tr,
                  style: TextStyle(fontSize: 18),
                ),
              );
  }
}
