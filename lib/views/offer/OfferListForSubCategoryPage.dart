import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/controllers/offers/search_binding.dart';
import 'package:test_ecommerce_app/controllers/offers/search_offer_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/cart/cart_screen.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/views/offer/widget/sorted_by.dart';
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/search_in_sub_categories.dart';
import 'package:test_ecommerce_app/views/widgets/search_screen.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:test_ecommerce_app/views/offer/OfferCard.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class OfferListForSubCategoryPage extends StatefulWidget {
  final String mainCategoryName;
  final int categoryId;
  const OfferListForSubCategoryPage(
      {Key? key, required this.mainCategoryName, required this.categoryId})
      : super(key: key);

  @override
  State<OfferListForSubCategoryPage> createState() =>
      _OfferListForSubCategoryPageState();
}

class _OfferListForSubCategoryPageState
    extends State<OfferListForSubCategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.backgroundContainer,
      appBar: AppBar(
          elevation: 0,
          // backgroundColor: ColorConstants.backgroundContainer,
          backgroundColor: Colors.transparent,
          flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness:
                Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                Get.isDarkMode ? Brightness.light : Brightness.dark,
              ),
              child: Container()),
          toolbarHeight: 78,
          leading: Utils.buildLeadingAppBar(title: widget.mainCategoryName),
          leadingWidth: 260,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: Utils.rightPadding16Left,
                  left: Utils.leftPadding16Right),
              child: _buildActionsAppBar(context: context),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: SearchInSubCategories(searchOnPressed: () {
              Get.put(SearchOfferController(Get.find()));
              Get.to(
                  () => SearchScreen(
                      typeOfSearch: TypeOfSearch.offersInMainCategory,
                      categoryId: widget.categoryId),
                  binding: SearchBinding());
            }, sortedByOnPressed: () {
              Get.bottomSheet(const SortedBy());
            }),
          )),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: OfferTab(),
    );
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        // appBarIcon(icon: Icons.search, iconColor: ColorConstants.mainColor),
        // const SizedBox(
        //   width: 8,
        // ),
        appBarIcon(
            icon: Icons.notifications, iconColor: ColorConstants.mainColor),
        const SizedBox(
          width: 8,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
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
              },
              child: appBarIcon(
                  icon: Icons.shopping_cart_rounded,
                  iconColor: ColorConstants.mainColor),
            ),
            Transform.translate(
              offset: const Offset(-9,-18),
              child: Align(
                  alignment: Controllers.directionalityController.languageBox.value
                      .read('language') ==
                      'ar'
                      ?
                  Alignment.centerLeft: Alignment.centerRight ,
                  child:Obx(()=>Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 19,height: 19,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                       Align(
                          alignment: Alignment.center,
                          child:  Text(Controllers.cartController.cartItems.length.toString(),
                                style: const TextStyle(color: ColorConstants.mainColor, fontSize: 12, fontWeight: FontWeight.bold)),


                      ),
                    ],
                  )
                  )
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget appBarIcon({required IconData icon, required Color iconColor}) {
    return Icon(
      icon,
      color: iconColor,
      size: 25,
    );
  }
}

class OfferTab extends StatefulWidget {
  const OfferTab({
    Key? key,
  }) : super(key: key);
  @override
  State<OfferTab> createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    setState(() {
      Controllers.offerController.filteredListOfferMainCategory.value =
          homeController.offersForMainCategory;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5, top: 20),
        child: _buildListOfOffers());
  }

  Widget _buildListOfOffers() {
    return Obx(() => homeController.isLoadingOffersMainCategory.value
        ? ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShimmerContainer(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 250,
                  topPadding: 0,
                  bottomPadding: 0,
                  rightPadding: 0,
                  leftPadding: 0),
            ),
          )
        : Controllers.offerController.filteredListOfferMainCategory.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: Controllers
                    .offerController.filteredListOfferMainCategory.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.put(OfferController(Get.find()));
                      Get.to(() => OfferDetail(
                          offerModel: Controllers.offerController
                              .filteredListOfferMainCategory[index]));
                    },
                    child: OfferCard(
                      offerModel: Controllers
                          .offerController.filteredListOfferMainCategory[index],
                      width: MediaQuery.of(context).size.width,
                      height: 248,
                    ),
                  );
                })
            : CenterImageForEmptyData(
                imagePath: 'assets/images/offer_empty.png',
                text: translation.noOffersAvailable.tr));
  }
}

class MerchantTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenterImageForEmptyData(
        imagePath: 'assets/images/merchant_empty.png',
        text: translation.noMerchantsAvailable.tr);
  }
}
