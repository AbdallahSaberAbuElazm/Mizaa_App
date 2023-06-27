import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
as translation;

class MostSellerOfferCard extends StatefulWidget {
  final OfferModel offerModel;
  final double width;
  final double height;
  const MostSellerOfferCard(
      {Key? key,
        required this.offerModel,
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
    companyModel = CompanyModel.fromJson(widget.offerModel.company!.map((key, value) => MapEntry(key.toString(), value)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: () {
          // Get.put(OfferController(Get.find()));
          // Get.to(() => OfferDetail(offerModel: widget.offerModel));
          showDialog(
              context: context,
              builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.mainColor,
                  )));
          Controllers.offerController.getOffer(offerKey: widget.offerModel.key.toString())
              .then((offer) {
            Get.back();
            Get.put(OfferController(Get.find()));
            Get.to(() => OfferDetail(offerModel:  offer));
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _buildOfferImage(),
                  _buildOfferDetailContainer(),
                ],
              ),
              Transform.translate(
                offset: const Offset(0,-10),
                child: Align(
                  alignment: Alignment.center,
                  child: MerchantLogo(merchantLogo:  companyModel.logo.toString(),
                      containerWidth: 43, containerHeight: 43,
                      logoWidth: 25, logoHeight: 25),

                ),
              ),
            ],
          ),
        ));
  }

  // offer Image
  Widget _buildOfferImage() {
    return Container(
      height: widget.height / 2 + 27,
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
            Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.backgroundContainer),
                child: const Icon(
                  Icons.favorite_border_outlined,
                  color: ColorConstants.mainColor,
                  size: 19,
                )),
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
    return Transform.translate(
        offset: const Offset(0, -19),
        child: Container(
          width: double.infinity,
          height: widget.height / 2,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
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
                              'companyName': Utils.getTranslatedText(arText: companyModel.arName.toString(), enText: companyModel.enName.toString())
                            }),
                          style: TextStyle(
                              fontSize: 13, color: ColorConstants.greyColor,fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 7,),
                      SizedBox(
                        height: 50,
                        width: widget.width/1.75,
                        child: Text(
                          translation.offerName.trParams({
                            'offerName': Utils.getTranslatedText(arText:  widget.offerModel.arTitle.toString(), enText: widget.offerModel.enTitle.toString())
                          }),
                          style: TextStyle(
                              fontSize: 12, color: ColorConstants.black0,height: 1.2,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildPriceContainer(
                      text: '${widget.offerModel.priceAfterDiscount.toString()}${translation.currencyName.tr}'),
                  const SizedBox(height: 2,),

                  Text(
                      '${widget.offerModel.priceBeforDiscount.toString()}${translation.currencyName.tr}',
                    style: TextStyle(
                        fontSize: 13, color: ColorConstants.greyColor,decoration: TextDecoration.lineThrough,),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
