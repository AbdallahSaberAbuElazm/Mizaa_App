import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/views/offer/widget/counter.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
as translation;

class ExpandedCard extends StatefulWidget {
  final String title;
  final String priceAfter;
  final String priceBefore;
  final String discount;
  final int index;
  const ExpandedCard({Key? key, required this.title, required this.priceAfter, required this.priceBefore, required this.discount, required this.index}) : super(key: key);

  @override
  _ExpandedCardState createState() => _ExpandedCardState();
}

class _ExpandedCardState extends State<ExpandedCard> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(expandedColor: Colors.white,baseColor: Colors.white,
      trailing: Icon(
          isExpanded? Icons.arrow_drop_up_outlined: Icons.arrow_right_outlined,
          color: isExpanded? ColorConstants.mainColor: ColorConstants.greyColor
      ), onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.bold,color: ColorConstants.black0
        ),
      ),
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        translation.currencyName.tr,
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
                        widget.priceAfter,
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
                          height: 30, width: 54, text: '${widget.discount}%'),
                    ],
                  ),
                  CounterScreen(index:widget.index)
                  // _drawCounter(index: index),
                ])),
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

}
