import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/models/companies/CompanyModel.dart';
import 'package:mizaa/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/providers/company_provider.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';

class CompanyController extends GetxController {
  CompanyProvider companyProvider;
  CompanyController(this.companyProvider);

  final companyModel = CompanyModel(
          id: 0,
          arName: '',
          enName: '',
          companyBrunches: [],
          creationDate: '',
          description: '',
          enDescription: '',
          facebook: '',
          headerPhoto: '',
          instegram: '',
          key: '',
          logo: '',
          snapchat: '',
          tiktok: '',
          twitter: '',
          website: '',
          whatsapp: '',
          youtube: '')
      .obs;

  final companyBranches = <CompanyBranchesModel>[].obs;
  var isLoadingCompanyBranches = true.obs;

  var isLoadingCompanyOffers = true.obs;
  final companyOffers = <OfferModel>[].obs;

  // app bar for merchant branches screen
  late ScrollController scrollMerchantBranchesController;
  final isScrolledMerchantBranches = false.obs;
  final appBarMerchantBranchesColor = Colors.transparent.obs;
  final appBarItemContainerMerchantBranchesColor = Colors.white.obs;
  final appBarItemMerchantBranchesColor = ColorConstants.mainColor.obs;

  // app bar for merchant detail screen
  late ScrollController scrollMerchantDetailController;
  final isScrolledMerchantDetail = false.obs;
  final appBarMerchantDetailColor = Colors.transparent.obs;
  final appBarItemContainerMerchantDetailColor = Colors.white.obs;
  final appBarItemMerchantDetailColor = ColorConstants.mainColor.obs;

  resetMerchantBranches() {
    isScrolledMerchantBranches.value = false;
    appBarMerchantBranchesColor.value = Colors.transparent;
    appBarItemContainerMerchantBranchesColor.value = Colors.white;
    appBarItemMerchantBranchesColor.value = ColorConstants.mainColor;
  }

  resetMerchantDetail() {
    isScrolledMerchantDetail.value = false;
    appBarMerchantDetailColor.value = Colors.transparent;
    appBarItemContainerMerchantDetailColor.value = Colors.white;
    appBarItemMerchantDetailColor.value = ColorConstants.mainColor;
  }

  @override
  void onInit() {
    scrollMerchantBranchesController = ScrollController()
      ..addListener(_onScrollMerchantBranches);
    scrollMerchantDetailController = ScrollController()
      ..addListener(_onScrollMerchantDetail);
    super.onInit();
  }

  void _onScrollMerchantBranches() {
    if (scrollMerchantBranchesController.offset > 80 &&
        !isScrolledMerchantBranches.value) {
      isScrolledMerchantBranches.value = true;
      appBarMerchantBranchesColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      appBarItemContainerMerchantBranchesColor.value = ColorConstants.mainColor;
      appBarItemMerchantBranchesColor.value = Colors.white;
    } else if (scrollMerchantBranchesController.offset <= 80 &&
        isScrolledMerchantBranches.value) {
      isScrolledMerchantBranches.value = false;
      appBarMerchantBranchesColor.value = Colors.transparent;
      appBarItemContainerMerchantBranchesColor.value = Colors.white;
      appBarItemMerchantBranchesColor.value = ColorConstants.mainColor;
    }
  }

  void _onScrollMerchantDetail() {
    if (scrollMerchantDetailController.offset > 20 &&
        !isScrolledMerchantDetail.value) {
      isScrolledMerchantDetail.value = true;
      appBarMerchantDetailColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      appBarItemContainerMerchantDetailColor.value = ColorConstants.mainColor;
      appBarItemMerchantDetailColor.value = Colors.white;
    } else if (scrollMerchantDetailController.offset <= 20 &&
        isScrolledMerchantDetail.value) {
      isScrolledMerchantDetail.value = false;
      appBarMerchantDetailColor.value = Colors.transparent;
      appBarItemContainerMerchantDetailColor.value = Colors.white;
      appBarItemMerchantDetailColor.value = ColorConstants.mainColor;
    }
  }

  void getCompanyBranches({required String companyKey}) {
    isLoadingCompanyBranches.value = true;
    companyProvider
        .getCompanyBranches(
            cityId: SharedPreferencesClass.getCityId().toString(),
            companyKey: companyKey)
        .then((branches) {
      companyBranches.value = branches;
      print('branches is $branches');
      isLoadingCompanyBranches.value = false;
    });
  }

  void getOffersForCompany({required String companyId}) {
    isLoadingCompanyOffers.value = true;
    companyProvider.getOffersForCompany(companyId: companyId).then((offers) {
      companyOffers.value = offers;
      isLoadingCompanyOffers.value = false;
    });
  }
}
