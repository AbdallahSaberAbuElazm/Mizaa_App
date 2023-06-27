import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/offer/OfferListForSubCategoryPage.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
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
          toolbarHeight: 90,
          leading: Utils.buildLeadingAppBar(title:  widget.subCategoryName),
          leadingWidth: 260,
          actions: [
            Padding(
              padding: const  EdgeInsets.only(
                  right: 16,
                  left:16),
              child: _buildActionsAppBar(context: context),
            )
          ],
          ),
        floatingActionButton:const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: _buildListOfOffers());
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        appBarIcon(icon: Icons.search, iconColor: ColorConstants.mainColor),
        const SizedBox(
          width: 8,
        ),
        appBarIcon(
            icon: Icons.notifications, iconColor: ColorConstants.mainColor),
        const SizedBox(
          width: 8,
        ),
        appBarIcon(
            icon: Icons.shopping_cart_rounded,
            iconColor: ColorConstants.mainColor),
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
            :  Center(
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
              mainCategoryName: category.enName,
              categoryId: category.id,
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        margin: const EdgeInsets.only(left: 16, right: 16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12))),
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
                      borderRadius:
                      Controllers.directionalityController.languageBox.value.read('language') == 'en'
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12))
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                  child: Text( Utils.getTranslatedText(arText: category.arName, enText: category.enName),
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
