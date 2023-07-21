import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/models/favourite/favourite_model.dart';
import 'package:test_ecommerce_app/providers/favourite_provider.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class FavouriteController extends GetxController {
  final FavouriteProvider favouriteProvider;
  FavouriteController(this.favouriteProvider);

  var isLoadingFavouriteList = true.obs;
  final favouriteList = <FavouriteModel>[].obs;

  // app bar for merchant detail screen
  late ScrollController scrollFavouriteTabController;
  final isScrolledFavouriteTab = false.obs;
  final appBarFavouriteTabColor = Colors.transparent.obs;
  final appBarItemContainerFavouriteTabColor = Colors.white.obs;
  final appBarItemFavouriteTabColor = ColorConstants.mainColor.obs;

  @override
  void onInit() async {
    scrollFavouriteTabController = ScrollController()
      ..addListener(_onScrollFavouriteTab);
    super.onInit();
  }

  void _onScrollFavouriteTab() {
    if (scrollFavouriteTabController.offset > 20 &&
        !isScrolledFavouriteTab.value) {
      isScrolledFavouriteTab.value = true;
      appBarFavouriteTabColor.value = Colors.white;
      appBarItemContainerFavouriteTabColor.value = ColorConstants.mainColor;
      appBarItemFavouriteTabColor.value = Colors.white;
    } else if (scrollFavouriteTabController.offset <= 20 &&
        isScrolledFavouriteTab.value) {
      isScrolledFavouriteTab.value = false;
      appBarFavouriteTabColor.value = Colors.transparent;
      appBarItemContainerFavouriteTabColor.value = Colors.white;
      appBarItemFavouriteTabColor.value = ColorConstants.mainColor;
    }
  }

  var isAddedToFavourite = false.obs;
  Future<bool> addToFavourites(
      {required int offerId, required BuildContext context}) async {
    isAddedToFavourite.value = false;
    await favouriteProvider.addToFavourites(offerId: offerId).then((value) {
      if (value == true) {
        Utils.snackBar(
            context: context,
            msg: translation.offerAddedToFavourite.tr,
            background: ColorConstants.greenColor,
            textColor: Colors.white);
        isAddedToFavourite.value = true;
      }
    });
    return isAddedToFavourite.value;
  }

  var isDeletedFromFavourites = false.obs;
  Future<bool> deleteFromFavourites(
      {required String favouriteKey, required BuildContext context}) async {
    await favouriteProvider
        .deleteFromFavourites(favouriteKey: favouriteKey)
        .then((value) {
      if (value == true) {
        favouriteProvider.getFavourites().then((value) {
          favouriteList.value = value;
        });
        isDeletedFromFavourites.value = value;
        Utils.snackBar(
            context: context,
            msg: translation.offerDeletedFromFavourite.tr,
            background: ColorConstants.greenColor,
            textColor: Colors.white);
      }
    });
    return isDeletedFromFavourites.value;
  }

  Future<List<FavouriteModel>> getUserFavourites() async {
    isLoadingFavouriteList.value = true;
    await favouriteProvider.getFavourites().then((value) {
      favouriteList.value = value;
      isLoadingFavouriteList.value = false;
    });
    return favouriteList;
  }
}
