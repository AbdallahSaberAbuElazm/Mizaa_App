import 'package:flutter/material.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:mizaa/models/companies/CompanyModel.dart';
import 'package:mizaa/models/favourite/favourite_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/views/merchant/merchant_offer_detail.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/widgets/custom_text_line_through.dart';
import 'package:mizaa/views/offer/widget/merchant_logo.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;

enum TypeOfComingOffer {
  comingFromMerchant,
  comingFromOffer,
  comingFromNearestOffer
}

class OfferCard extends StatefulWidget {
  final OfferModel offerModel;
  final TypeOfComingOffer typeOfComingOffer;
  final dynamic onTapFavourite;
  final double width;
  final double height;
  final bool isComingFromFavourite;
  const OfferCard(
      {Key? key,
      required this.offerModel,
      required this.typeOfComingOffer,
      required this.onTapFavourite,
      required this.width,
      required this.height,
      required this.isComingFromFavourite})
      : super(key: key);

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
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

            if (widget.typeOfComingOffer ==
                TypeOfComingOffer.comingFromMerchant) {
              Get.put(OfferController(Get.find()))
                  .resetMerchantOfferDetailScrolling();
              Controllers.offerController.cartItemsOfferDetail.clear();
              Get.to(() => MerchantOfferDetail(offerModel: offer));
            } else {
              Get.put(OfferController(Get.find())).resetOfferDetailScrolling();
              Controllers.offerController.cartItemsOfferDetail.clear();
              Get.to(() => OfferDetail(offerModel: offer));
            }
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
                offset: const Offset(0, 2), // controls the offset of the shadow
                blurRadius: 4, // controls the blur radius of the shadow
                spreadRadius: 0, // controls the spread radius of the shadow
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Align(alignment: Alignment.topCenter, child: _buildOfferImage()),
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                    offset: const Offset(0, -7),
                    child: Container(
                        width: double.infinity,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))))),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildOfferDetailContainer()),
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
        padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: widget.onTapFavourite,
              child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.backgroundContainer),
                  child: Icon(
                    widget.isComingFromFavourite
                        ? Icons.favorite_outlined
                        : widget.offerModel.isFavourite!
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
      height: widget.height / 2 + 2,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 3),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MerchantLogo(
                  merchantLogo: companyModel.logo.toString(),
                  containerWidth: 43,
                  containerHeight: 43,
                  logoWidth: 25,
                  logoHeight: 25),
              const SizedBox(
                width: 9,
              ),
              Expanded(
                child: SizedBox(
                  // height: 43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Utils.getTranslatedText(
                            arText: companyModel.arName.toString(),
                            enText: companyModel.enName.toString()),
                        style: TextStyle(
                            fontSize: 13,
                            color: ColorConstants.greyColor,
                            fontWeight: FontWeight.w500),
                      ),
                      widget.typeOfComingOffer ==
                              TypeOfComingOffer.comingFromNearestOffer
                          ? SizedBox(
                              child: Text(
                                '${Utils.getTranslatedText(arText: widget.offerModel.arAddress.toString(), enText: widget.offerModel.enAddress.toString())} - ${Utils.getTranslatedText(arText: widget.offerModel.arDiscrict.toString(), enText: widget.offerModel.enDiscrict.toString())}', //TODO
                                style: TextStyle(
                                    fontSize: 10,
                                    color: ColorConstants.greyColor,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
              height: 28,
              // width: widget.width - 105,
              child: Text(
                Utils.getTranslatedText(
                    arText: widget.offerModel.arTitle.toString(),
                    enText: widget.offerModel.enTitle.toString()),
                style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.black0,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPriceContainer(
                  text:
                      '${widget.offerModel.priceAfterDiscount.toString()} ${translation.currencyName.tr}'),
              const SizedBox(
                width: 9,
              ),
              CustomTextLineThrough(
                  text:
                      '${widget.offerModel.priceBeforDiscount.toString()} ${translation.currencyName.tr}',
                  textColor: ColorConstants.greyColor),
            ],
          ),
        ],
      ),
    );
  }
}
