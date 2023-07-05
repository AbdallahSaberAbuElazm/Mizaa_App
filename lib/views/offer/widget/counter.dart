import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';

class CounterScreen extends StatefulWidget {
  final int index;
  const CounterScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                setState(() {
                  Controllers.offerController
                      .incrementQuantityOfCartItemOfferDetail(
                          index: widget.index);
                  print(
                      'quantity is ${Controllers.offerController.cartItemsOfferDetail[widget.index].count}');
                });
              },
              child: Container(
                width: 23,
                height: 21,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: ColorConstants.mainColor,
                    size: 18,
                  ),
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          Obx(() => Text(
                '${(Controllers.offerController.cartItemsOfferDetail.isNotEmpty) ? Controllers.offerController.cartItemsOfferDetail[widget.index].count.value == 0 ? widget.index == 0 ? 1 : Controllers.offerController.cartItemsOfferDetail[widget.index].count.value : Controllers.offerController.cartItemsOfferDetail[widget.index].count.value : widget.index == 0 ? 1 : 0}',
                style: TextStyle(
                    color: ColorConstants.black0,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              )),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  Controllers.offerController
                      .decrementQuantityOfCartItemOfferDetail(
                          index: widget.index);
                  print(
                      'quantity is ${Controllers.offerController.cartItemsOfferDetail[widget.index].count}');
                });
              },
              child: Container(
                width: 23,
                height: 21,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: ColorConstants.mainColor,
                    size: 18,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
