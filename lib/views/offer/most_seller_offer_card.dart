import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/favourite/favourite_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class MostSellerOfferCard extends StatefulWidget {
  final OfferModel offerModel;
  final int index;
  final double width;
  final double height;
  const MostSellerOfferCard(
      {Key? key,
      required this.offerModel,
      required this.index,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<MostSellerOfferCard> createState() => _MostSellerOfferCardState();
}

class _MostSellerOfferCardState extends State<MostSellerOfferCard> {
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1.4), // controls the offset of the shadow
                blurRadius: 3, // controls the blur radius of the shadow
                spreadRadius: 0, // controls the spread radius of the shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _buildOfferImage(),
                  _buildOfferDetailContainer(),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                    offset: const Offset(0, -4),
                    child: Container(
                        width: double.infinity,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))))),
              ),
              Transform.translate(
                offset: const Offset(0, -10),
                child: Align(
                  alignment: Alignment.center,
                  child: MerchantLogo(
                      merchantLogo: companyModel.logo.toString(),
                      containerWidth: 43,
                      containerHeight: 43,
                      logoWidth: 25,
                      logoHeight: 25),
                ),
              ),
            ],
          ),
        ));
  }

  // offer Image
  Widget _buildOfferImage() {
    return Container(
      height: widget.height / 2,
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            '${ApiConstants.storageURL}${widget.offerModel.mainImage.toString()}',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (SharedPreferencesClass.getToken() == null ||
                    SharedPreferencesClass.getToken() == '') {
                  Utils.showAlertDialogForRegisterLogin(context: context);
                } else {
                  if (widget.offerModel.isFavourite!) {
                    Controllers.favouriteController
                        .getUserFavourites()
                        .then((favouriteList) {
                      FavouriteModel favouriteModel = favouriteList.firstWhere(
                          (offer) => widget.offerModel.id == offer.offerId);
                      Controllers
                              .homeController.mostSellerOffers[widget.index] =
                          Controllers
                              .homeController.mostSellerOffers[widget.index]
                              .copyWith(isFavourite: false);
                      Controllers.favouriteController.deleteFromFavourites(
                          favouriteKey: favouriteModel.key, context: context);
                      Controllers.homeController.getMostSalesOffers();
                    });
                  } else {
                    Controllers.homeController.mostSellerOffers[widget.index] =
                        Controllers
                            .homeController.mostSellerOffers[widget.index]
                            .copyWith(isFavourite: true);
                    Controllers.favouriteController.addToFavourites(
                        offerId: widget.offerModel.id!, context: context);
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
            _buildPriceContainer(text: '${widget.offerModel.enDiscount}%'),
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
    return Container(
      width: double.infinity,
      height: widget.height / 2,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 50,
                width: widget.width / 1.75,
                child: Text(
                  translation.offerName.trParams({
                    'offerName': Utils.getTranslatedText(
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
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPriceContainer(
                  text:
                      '${widget.offerModel.priceAfterDiscount.toString()}${translation.currencyName.tr}'),
              const SizedBox(
                height: 2,
              ),
              Text(
                '${widget.offerModel.priceBeforDiscount.toString()}${translation.currencyName.tr}',
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstants.greyColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
