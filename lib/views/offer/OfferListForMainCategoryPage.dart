import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/controllers/offers/search_binding.dart';
import 'package:test_ecommerce_app/controllers/offers/search_offer_controller.dart';
import 'package:test_ecommerce_app/models/merchant/merchant_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/providers/company_provider.dart';
import 'package:test_ecommerce_app/repositories/company_repository.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/cart/cart_screen.dart';
import 'package:test_ecommerce_app/views/merchant/merchant_detail.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/views/offer/widget/filtration_screen.dart';
import 'package:test_ecommerce_app/views/offer/widget/merchant_logo.dart';
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/search_screen.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:test_ecommerce_app/views/offer/OfferCard.dart';
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';
import 'package:test_ecommerce_app/views/widgets/search_in_categories.dart';
import 'package:test_ecommerce_app/views/offer/widget/sorted_by.dart';

enum TypeOfCategory { mainCategory, specificOffers }

class OfferListForMainCategoryPage extends StatefulWidget {
  final String mainCategoryName;
  final int categoryId;
  final TypeOfCategory typeOfCategory;
  final List<OfferModel> offers;
  const OfferListForMainCategoryPage(
      {Key? key,
      required this.mainCategoryName,
      required this.categoryId,
      required this.offers,
      required this.typeOfCategory})
      : super(key: key);

  @override
  State<OfferListForMainCategoryPage> createState() =>
      _OfferListForMainCategoryPageState();
}

class _OfferListForMainCategoryPageState
    extends State<OfferListForMainCategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          switch (_tabController.index) {
            case 0:
              setState(() {
                tabIndex = 0;
              });
              break;
            case 1:
              setState(() {
                tabIndex = 1;
              });
              break;
          }
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        toolbarHeight:
            widget.typeOfCategory == TypeOfCategory.mainCategory ? 125 : 85,
        leading: Utils.buildLeadingAppBar(
          title: widget.mainCategoryName,
        ),
        leadingWidth: 260,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                  right: 16,
                left: 16),
            child: _buildActionsAppBar(context: context),
          )
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                widget.typeOfCategory == TypeOfCategory.mainCategory
                    ? SearchInCategories(searchOnPressed: () {
                        Get.put(SearchOfferController(Get.find()));
                        Get.to(
                            () => SearchScreen(
                                typeOfSearch: (tabIndex == 0)
                                    ? TypeOfSearch.offersInMainCategory
                                    : TypeOfSearch.merchant,
                                categoryId: widget.categoryId),
                            binding: SearchBinding());
                      }, filterOnPressed: () {

                  setState(() {
                    Controllers.offerController.filteredListOfferMainCategory.value =
                        widget.offers;
                    Controllers.homeController.selectedSubCategories.value = '';
                    Get.to(() => const FiltrationScreen());
                  });

                      }, sortedByOnPressed: () {
                        Get.bottomSheet(const SortedBy());
                      })
                    : const SizedBox.shrink(),
                TabBar(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: widget.typeOfCategory == TypeOfCategory.mainCategory
                          ? 10
                          : 0),
                  controller: _tabController,
                  labelColor: ColorConstants
                      .mainColor, // Change the selected tab text color
                  unselectedLabelColor: Get.isDarkMode? Colors.white:ColorConstants.black0,
                  labelStyle: const TextStyle(
                      fontFamily: 'Noto Kufi Arabic',
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(
                      fontFamily: 'Noto Kufi Arabic',
                      fontSize: 15,
                      color: ColorConstants.greyColor,
                      fontWeight: FontWeight.w500),

                  dividerColor: ColorConstants.mainColor,
                  indicatorColor: ColorConstants.mainColor,
                  tabs: [
                    Tab(
                        child: Text(
                      translation.offersText.tr,
                    )),
                    Tab(
                        child: Text(
                      translation.merchantsText.tr,
                    )),
                  ],
                ),
              ],
            )),
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 27),
        child: TabBarView(
          controller: _tabController,
          children: [
            OfferTab(
              typeOfCategory: widget.typeOfCategory,
              offers: widget.offers,
            ),
            MerchantTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        widget.typeOfCategory == TypeOfCategory.mainCategory
            ? const SizedBox.shrink()
            : appBarIcon(
                onTap: () {},
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
        appBarIcon(
            icon: Icons.shopping_cart_rounded,
            iconColor: ColorConstants.mainColor,
            onTap: () {
              Get.put(CartController(Get.find()));
              Get.to(() => const CartScreen(
                    comingForCart: ComingForCart.offerListCategory,
                  ));
            }),
      ],
    );
  }

  Widget appBarIcon(
      {required IconData icon,
      required Color iconColor,
      required dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: iconColor,
        size: 25,
      ),
    );
  }
}

class OfferTab extends StatefulWidget {
  final List<OfferModel> offers;
  final TypeOfCategory typeOfCategory;
  const OfferTab({Key? key, required this.typeOfCategory, required this.offers})
      : super(key: key);
  @override
  State<OfferTab> createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
  final HomeController homeController = Get.find();
  @override
  void initState() {
    setState(() {
      Controllers.offerController.filteredListOfferMainCategory.value =
          widget.offers;
      homeController.selectedSubCategories.value = '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(physics: const ScrollPhysics(), children: [
          Controllers.offerController.filteredListOfferMainCategory.isNotEmpty
              ?  widget.typeOfCategory == TypeOfCategory.mainCategory
              ? _buildSubCategoriesForMainCategory()
              : const SizedBox.shrink( ): const SizedBox.shrink(),
          _buildListOfOffers()
        ])
      ),
    );
  }

  Widget _buildSubCategoriesForMainCategory() {
    return SizedBox(
        height: 38,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => ListView.builder(
              itemCount: homeController.subCategories.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      homeController.selectedSubCategories.value =
                          Utils.getTranslatedText(
                              arText: homeController.subCategories[index].arName
                                  .toString(),
                              enText: homeController.subCategories[index].enName
                                  .toString());
                    });
                    homeController.getOffersForSubCategories(
                        subCategoryId:
                            homeController.subCategories[index].id.toString());
                  },
                  child: Container(
                      height: 38,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 4),
                      margin: const EdgeInsets.only(right: 4, left: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 0.5,
                            color: homeController.selectedSubCategories.value ==
                                    Utils.getTranslatedText(
                                        arText: homeController
                                            .subCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .subCategories[index].enName
                                            .toString())
                                ? Colors.transparent
                                : ColorConstants.greyColor),
                        color: homeController.selectedSubCategories.value ==
                                Utils.getTranslatedText(
                                    arText: homeController
                                        .subCategories[index].arName
                                        .toString(),
                                    enText: homeController
                                        .subCategories[index].enName
                                        .toString())
                            ? ColorConstants.mainColor
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          homeController.subCategories[index].arName,
                          style: TextStyle(
                            fontSize: 15,
                            color: homeController.selectedSubCategories.value ==
                                    Utils.getTranslatedText(
                                        arText: homeController
                                            .subCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .subCategories[index].enName
                                            .toString())
                                ? Colors.white
                                : ColorConstants.greyColor,
                            height: 1.7,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                      )),
                );
              }),
        ));
  }

  Widget _buildListOfOffers() {
    return Obx(() => homeController.isLoadingOffersMainCategory.value == true
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 5,
                top: widget.typeOfCategory == TypeOfCategory.mainCategory
                    ? 20
                    : 0),
            physics: const NeverScrollableScrollPhysics(),
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
        :
        // widget.offers.isNotEmpty
        Controllers.offerController.filteredListOfferMainCategory.isNotEmpty
            ?
        ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 10,
                    top: widget.typeOfCategory == TypeOfCategory.mainCategory
                        ? 20
                        : 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Controllers
                    .offerController.filteredListOfferMainCategory.length,
                // widget.offers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.put(OfferController(Get.find()));
                      Get.to(() => OfferDetail(
                          offerModel:
                              // widget.offers[index]
                              Controllers.offerController
                                  .filteredListOfferMainCategory[index]));
                    },
                    child: OfferCard(
                      offerModel: Controllers
                          .offerController.filteredListOfferMainCategory[index],
                      // widget.offers[index],
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                    ),
                  );
                }): Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/2 ),
                  child: CenterImageForEmptyData(imagePath: 'assets/images/offer_empty.png', text: translation.noOffersAvailable.tr),
                ),

            );
  }
}

class MerchantTab extends GetView<OfferController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.merchants.isNotEmpty
        ?ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.merchants.length,
        itemBuilder: (context, index) {
          return _buildMerchantCard(
              context: context, companyModel: controller.merchants[index]);
        }) :
    CenterImageForEmptyData(imagePath: 'assets/images/merchant_empty.png', text: translation.noMerchantsAvailable.tr));
  }

  Widget _buildMerchantCard(
      {required BuildContext context, required MerchantModel companyModel}) {
    return GestureDetector(
      onTap: (){
        // print('merchant key is ${searchModel.key.toString()}');
        showDialog(
            context: context,
            builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        Controllers.searchOfferController.getMerchant(merchantKey: companyModel.key.toString()).then((companyModel) {
          Get.back();
          Get.put(CompanyRepository());
          Get.put(CompanyProvider(Get.find()));
          Get.put(CompanyController(Get.find()));

          Get.to(() => MerchantDetail(companyModel: companyModel,),);
        });

      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 88,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: ListTile(
            leading: MerchantLogo(
                merchantLogo: companyModel.logo.toString(),
                containerWidth: 55,
                containerHeight: 60,
                logoWidth: 32,
                logoHeight: 32),
            trailing: Controllers.directionalityController.languageBox.value.read('language') ==
                'ar'
                ?   Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorConstants.greyColor,
              size: 18,
            ): Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorConstants.greyColor,
              size: 18,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTexts.textTitle(
                    text: translation.offerName.trParams({
                  'offerName': Utils.getTranslatedText(
                      arText: companyModel.arname.toString(),
                      enText: companyModel.enname.toString())
                })),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 22,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: ColorConstants.mainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child:  Center(
                      child: Text(
                    '${companyModel.count} ${translation.offersText.tr}',
                    style:const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Noto Kufi Arabic',
                        height: 1.4),
                    // textAlign: TextAlign.center,
                  )),
                )
              ],
            ),
          )),
    );
  }
}
