import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/favourite/favourite_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/views/widgets/custom_text_line_through.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';

class NewOfferCard extends StatefulWidget {
  final OfferModel offerModel;
  final double width;
  final double height;
  const NewOfferCard(
      {Key? key,
      required this.offerModel,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<NewOfferCard> createState() => _NewOfferCardState();
}

class _NewOfferCardState extends State<NewOfferCard> {
  late CompanyModel companyModel;
  @override
  void initState() {
    companyModel = CompanyModel.fromJson(widget.offerModel.company!
        .map((key, value) => MapEntry(key.toString(), value)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: ColorConstants.mainColor,
                  )));
          Controllers.offerController
              .getOffer(offerKey: widget.offerModel.key.toString())
              .then((offer) {
            Get.back();
            Get.put(OfferController(Get.find()));
            Controllers.offerController.cartItemsOfferDetail.clear();
            Get.to(() => OfferDetail(offerModel: offer));
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.only(top: 6, bottom: 6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.gray100,
                offset: Offset(0, 2), // controls the offset of the shadow
                blurRadius: 4, // controls the blur radius of the shadow
                spreadRadius: 0, // controls the spread radius of the shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildOfferImage(),
              _buildOfferDetailContainer(),
            ],
          ),
        ));
  }

  // offer Image
  Widget _buildOfferImage() {
    return Container(
      height: widget.height,
      width: widget.width / 2 - 65,
      decoration: BoxDecoration(
        borderRadius: Controllers.directionalityController.languageBox.value
                    .read('language') ==
                'ar'
            ? BorderRadius.only(
                topRight: Radius.circular(12), bottomRight: Radius.circular(12))
            : BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            '${ApiConstants.storageURL}${widget.offerModel.mainImage.toString()}',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 13, left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 55,
                child: _buildPriceContainer(
                    text: '${widget.offerModel.enDiscount}%')),
            MerchantLogo(
                merchantLogo: companyModel.logo.toString(),
                containerWidth: 38,
                containerHeight: 35,
                logoWidth: 22,
                logoHeight: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceContainer({required String text}) {
    return Container(
      height: 24,
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

  // offer detail
  Widget _buildOfferDetailContainer() {
    return Expanded(
      child: Container(
        // width:  widget.width / 2 + 36,
        height: widget.height,
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Controllers.directionalityController.languageBox.value
                        .read('language') ==
                    'ar'
                ? BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
                : BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: widget.width / 2 + 9,
              height: widget.height - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 22,
                        child: Text(
                          translation.companyName.trParams({
                            'companyName': Utils.getTranslatedText(
                                arText: companyModel.arName.toString(),
                                enText: companyModel.enName.toString())
                          }),
                          style: TextStyle(
                              fontSize: 13,
                              color: ColorConstants.greyColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (SharedPreferencesClass.getToken() == null ||
                              SharedPreferencesClass.getToken() == '') {
                            Utils.showAlertDialogForRegisterLogin(
                                context: context);
                          } else {
                            if (widget.offerModel.isFavourite!) {
                              Controllers.favouriteController
                                  .getUserFavourites()
                                  .then((favouriteList) {
                                FavouriteModel favouriteModel =
                                    favouriteList.firstWhere((offer) =>
                                        widget.offerModel.id == offer.offerId);
                                // Controllers.homeController.todayOffers[index].copyWith(isFavourite: false);
                                Controllers.favouriteController
                                    .deleteFromFavourites(
                                        favouriteKey: favouriteModel.key,
                                        context: context)
                                    .then((value) {
                                  print('value of delete is $value');
                                  if (value) {
                                    Controllers.homeController
                                        .getSpecialOffers();
                                  }
                                });
                                Controllers.homeController.getSpecialOffers();
                              });
                            } else {
                              Controllers.favouriteController
                                  .addToFavourites(
                                      offerId: widget.offerModel.id!,
                                      context: context)
                                  .then((value) {
                                Controllers.homeController.getSpecialOffers();
                              });
                            }
                          }
                        },
                        child: Container(
                            width: 29,
                            height: 29,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.backgroundContainer),
                            child: Icon(
                              widget.offerModel.isFavourite!
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_border_outlined,
                              color: ColorConstants.mainColor,
                              size: 22,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 33,
                    width: widget.width / 2 - 20,
                    child: Text(
                      translation.companyName.trParams({
                        'companyName': Utils.getTranslatedText(
                            arText: widget.offerModel.arTitle.toString(),
                            enText: widget.offerModel.enTitle.toString())
                      }),
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.black0,
                          height: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildPriceContainer(
                          text: translation.companyName.trParams({
                        'companyName':
                            '${widget.offerModel.priceAfterDiscount.toString()} ${translation.currencyName.tr}',
                      })),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomTextLineThrough(
                          text: translation.companyName.trParams({
                            'companyName':
                                '${widget.offerModel.priceBeforDiscount.toString()} ${translation.currencyName.tr}',
                          }),
                          textColor: ColorConstants.greyColor)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
