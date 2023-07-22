import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizaa/controllers/cart/cart_controller.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/offers/search_offer_controller.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/cart/cart_screen.dart';
import 'package:get/get.dart';
import 'package:mizaa/views/offer/OfferListForMainCategoryPage.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/search_screen.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';
import 'package:mizaa/controllers/offers/search_binding.dart';

class CategoriesTab extends StatefulWidget {
  CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  void initState() {
    Controllers.homeController.getMainCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: ColorConstants.backgroundContainer,
        flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
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
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        leadingWidth: 260,
        leading: Padding(
          padding: EdgeInsets.only(
              right: Utils.rightPadding12Right, left: Utils.leftPadding12Left),
          child: Row(children: [
            Text(
              translation.categoriesText.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Noto Kufi Arabic',
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        // Utils.buildLeadingAppBar(
        //   title: translation.categoriesText.tr,
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14, left: 14),
            child: _buildActionsAppBar(context: context),
          )
        ],
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Padding(
          padding: const EdgeInsets.only(top: 27),
          child: _buildListOfCategories()),
    );
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        appBarIcon(
            onTap: () {
              Get.put(SearchOfferController(Get.find()));
              Get.to(
                  () => SearchScreen(
                      typeOfSearch: TypeOfSearch.globalSearchWithCity,
                      categoryId: -1),
                  binding: SearchBinding());
            },
            icon: Icons.search,
            iconColor: ColorConstants.mainColor),
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
            Transform.translate(
              offset: const Offset(-9, -18),
              child: Align(
                  alignment: Controllers
                              .directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 17, height: 17,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                              0, 1.4), // controls the offset of the shadow
                          blurRadius:
                              3, // controls the blur radius of the shadow
                          spreadRadius:
                              0, // controls the spread radius of the shadow
                        ),
                      ],
                    ),
                    child: Text(
                        Controllers.cartController.cartItems.length.toString(),
                        style: const TextStyle(
                            color: ColorConstants.mainColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold)),
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildListOfCategories() {
    return Obx(
      () => (Controllers.homeController.isLoadingMainCategories.value)
          ? ListView.builder(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ShimmerContainer(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 92,
                    topPadding: 0,
                    bottomPadding: 0,
                    rightPadding: 0,
                    leftPadding: 0),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 14, right: 14),
              itemCount: Controllers.homeController.mainCategories.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 92,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                        onTap: () {
                          Controllers.homeController.getOffersForMainCategories(
                            categoryId: Controllers
                                .homeController.mainCategories[index].id
                                .toString(),
                          );
                          Controllers.homeController.getSubCategories(
                              categoryId: Controllers
                                  .homeController.mainCategories[index].id
                                  .toString());

                          Get.to(() => OfferListForMainCategoryPage(
                                typeOfCategory: TypeOfCategory.mainCategory,
                                mainCategoryName:
                                    translation.categoryName.trParams({
                                  'categoryName': Utils.getTranslatedText(
                                      arText: Controllers.homeController
                                          .mainCategories[index].arName
                                          .toString(),
                                      enText: Controllers.homeController
                                          .mainCategories[index].enName
                                          .toString())
                                }),
                                categoryId: int.parse(Controllers
                                    .homeController.mainCategories[index].id
                                    .toString()),
                                offers: Controllers
                                    .homeController.offersForMainCategory,
                              ));
                          Controllers.homeController.isLoadingOffersMainCategory
                              .value = true;
                          print(
                              'isloading is from category ${Controllers.homeController.isLoadingOffersMainCategory.value}');
                          Get.put(OfferController(Get.find())).getMerchant(
                              catId: Controllers
                                  .homeController.mainCategories[index].id
                                  .toString());
                        },
                        leading: Image.asset(
                          Utils.categoryImageIcon[index],
                          width: 46,
                          height: 46,
                          color: ColorConstants.mainColor,
                        ),
                        title: Text(
                          Utils.getTranslatedText(
                              arText: Controllers
                                  .homeController.mainCategories[index].arName
                                  .toString(),
                              enText: Controllers
                                  .homeController.mainCategories[index].enName
                                  .toString()),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.black0,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                        trailing: Icon(
                          Controllers.directionalityController.languageBox.value
                                      .read('language') ==
                                  'ar'
                              ? Icons.arrow_back_ios_new_rounded
                              : Icons.arrow_forward_ios_rounded,
                          size: 18,
                        )));
              }),
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
}
