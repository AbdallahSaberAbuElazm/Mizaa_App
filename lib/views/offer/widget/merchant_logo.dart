import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';

class MerchantLogo extends StatelessWidget {
  final double containerWidth;
  final double containerHeight;
  final double logoWidth;
  final double logoHeight;
  final String merchantLogo;

  const MerchantLogo({
    Key? key,
    required this.merchantLogo,
    required this.containerWidth,
    required this.containerHeight,
    required this.logoWidth,
    required this.logoHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerWidth,
      width: containerHeight,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.mainColor,
            spreadRadius: 0.2,
            blurRadius: 0.2,
            offset: Offset(0, 0.1),
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: ApiConstants.storageURL + merchantLogo.toString(),
        width: logoWidth,
        height: logoHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
