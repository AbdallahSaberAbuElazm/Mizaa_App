import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/cart/cart_controller.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/home/HomeController.dart';
import 'package:mizaa/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/cart/cart_screen.dart';
import 'package:mizaa/views/offer/OfferListForSubCategoryPage.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;

class SubCategoryPage extends StatefulWidget {
  final String subCategoryName;
  final List<SubCategoriesModel> categories;
  const SubCategoryPage(
      {Key? key, required this.subCategoryName, required this.categories})
      : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: ColorConstants.backgroundContainer,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: ColorConstants.backgroundContainer,
          backgroundColor: Colors.transparent,
          flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                systemNavigationBarColor: Get.isDarkMode
                    ? ColorConstants.darkMainColor
                    : Colors.white, // navigation bar color
                systemNavigationBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
              ),
              child: Container()),
          toolbarHeight: 90,
          leading: Utils.buildLeadingAppBar(title: widget.subCategoryName),
          leadingWidth: 260,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: _buildActionsAppBar(context: context),
            )
          ],
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: _buildListOfOffers());
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        appBarIcon(
            icon: Icons.search,
            iconColor: ColorConstants.mainColor,
            onTap: () {}),
        const SizedBox(
          width: 8,
        ),
        appBarIcon(
            icon: Icons.notifications,
            iconColor: ColorConstants.mainColor,
            onTap: () {}),
        const SizedBox(
          width: 8,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            appBarIcon(
                icon: Icons.shopping_cart_rounded,
                iconColor: ColorConstants.mainColor,
                onTap: () {
                  if (SharedPreferencesClass.getToken() == null ||
                      SharedPreferencesClass.getToken() == '') {
                    Utils.showAlertDialogForRegisterLogin(context: context);
                  } else {
                    Get.put(CartController(Get.find()));
                    Get.to(() => const CartScreen(
                          comingForCart: ComingForCart.offerListCategory,
                        ));
                  }
                }),
            Controllers.cartController.cartItems.isNotEmpty
                ? Transform.translate(
                    offset: const Offset(-9, -18),
                    child: Align(
                        alignment: Controllers
                                    .directionalityController.languageBox.value
                                    .read('language') ==
                                'ar'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Obx(() => Container(
                              width: 17, height: 17,
                              alignment: Alignment.center,
                              // padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,
                                        1.4), // controls the offset of the shadow
                                    blurRadius:
                                        3, // controls the blur radius of the shadow
                                    spreadRadius:
                                        0, // controls the spread radius of the shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                  Controllers.cartController.cartItems.length
                                      .toString(),
                                  style: const TextStyle(
                                      color: ColorConstants.mainColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ))),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ],
    );
  }

  Widget appBarIcon(
      {required IconData icon,
      required Color iconColor,
      required dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 37,
          height: 37,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            icon,
            color: iconColor,
            size: 25,
          )),
    );
  }

  Widget _buildListOfOffers() {
    return
        // Obx(() => homeController.isLoadingOffersSubCategory.value == true
        //     ?
        // ListView.builder(
        //   itemCount: 2,
        //   itemBuilder: (context, index) => Padding(
        //     padding: const EdgeInsets.only(bottom: 16),
        //     child: ShimmerContainer(
        //         width: MediaQuery.of(context).size.width,
        //         height: 250,
        //         topPadding: 0,
        //         bottomPadding: 0,
        //         rightPadding: 0,
        //         leftPadding: 0),
        //   ),
        // )
        //     :
        widget.categories.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child:
                          _buildOfferCard(category: widget.categories[index]));
                },
              )
            : Center(
                child: Text(
                  translation.noDataYet.tr,
                  style: TextStyle(fontSize: 18),
                ),
                // )
              );
  }

  Widget _buildOfferCard({required SubCategoriesModel category}) {
    return GestureDetector(
      onTap: () {
        homeController.getOffersForSubCategories(
          subCategoryId: category.id.toString(),
        );
        Get.to(() => OfferListForSubCategoryPage(
              mainCategoryName: Utils.getTranslatedText(
                  arText: category.arName, enText: category.enName),
              // category.enName,
              categoryId: category.id,
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        margin: const EdgeInsets.only(left: 12, right: 12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1.4), // controls the offset of the shadow
            blurRadius: 3, // controls the blur radius of the shadow
            spreadRadius: 0, // controls the spread radius of the shadow
          ),
        ], borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Container(
                height: 110,
                width: MediaQuery.of(context).size.width / 1.6,
                decoration: BoxDecoration(
                  borderRadius: SharedPreferencesClass.getLanguageCode() == 'en'
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))
                      : const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      '${ApiConstants.storageURL}${category.imageUrl.toString()}',
                    ),
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'en'
                          ? const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                  child: Text(
                    Utils.getTranslatedText(
                        arText: category.arName, enText: category.enName),
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: ColorConstants.black0,
                        fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
