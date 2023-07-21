import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';

class FiltrationScreen extends StatefulWidget {
  // final String categoryId;
  const FiltrationScreen({
    Key? key,
    // required this.categoryId,
  }) : super(key: key);

  @override
  State<FiltrationScreen> createState() => _FiltrationScreenState();
}

class _FiltrationScreenState extends State<FiltrationScreen> {
  final HomeController homeController = Get.find();
  int selectedIndex = -1;

  List<String>? checkedData;
  List<String>? listId;
  @override
  void initState() {
    super.initState();
    checkedData = List.filled(homeController.subCategories.length, '');
    listId = List.filled(homeController.subCategories.length, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.backgroundContainer,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  Get.isDarkMode ? Brightness.light : Brightness.dark,
              statusBarBrightness:
                  Get.isDarkMode ? Brightness.light : Brightness.dark,
            ),
            child: Container()),
        centerTitle: true,
        leadingWidth: 104,
        leading: Padding(
          padding: EdgeInsets.only(
              left: Utils.leftPadding12Left, right: Utils.rightPadding12Right),
          child: Container(
              child: IntrinsicWidth(
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      checkedData =
                          List.filled(homeController.subCategories.length, '');
                      listId =
                          List.filled(homeController.subCategories.length, '');
                      Controllers.offerController.filterCountryName.value = '';
                      Controllers.offerController.filterCityName.value = '';
                      Controllers.offerController.filterCountryId.value = '';
                      Controllers.offerController.filterCityId.value = '';
                    });
                  },
                  child: Text(
                    translation.reset.tr,
                    style: TextStyle(
                        color: ColorConstants.greyColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  )),
            ],
          ))),
        ),
        title: Text(
          translation.filtration.tr,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: 15,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Controllers.offerController.filterCountryName.value = '';
                  Controllers.offerController.filterCityName.value = '';
                  Controllers.offerController.filterCountryId.value = '';
                  Controllers.offerController.filterCityId.value = '';
                });
                Get.back();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: ColorConstants.mainColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              child: CustomButton(
                btnOnpressed: () {
                  if (listId!.isNotEmpty) {
                    setState(() {
                      Controllers.offerController.filteredListOfferMainCategory
                              .value =
                          Controllers
                              .offerController.filteredListOfferMainCategory
                              .where((offer) => listId!
                                  .contains(offer.subCategoryId.toString()))
                              .toList();
                      Get.back();
                    });
                  }
                },
                textSize: 18,
                textColor: Colors.white,
                btnBackgroundColor: ColorConstants.mainColor,
                btnText: translation.applyFiltrationText.tr,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: ColorConstants.mainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_outlined,
                color: Colors.white,
                size: 25,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationContainer(),
            const SizedBox(
              height: 16,
            ),
            _buildCountryCityContainer(),
            const SizedBox(
              height: 20,
            ),
            _buildTextWithIcon(
                text: translation.categoriesText.tr,
                icon: Icons.category_rounded),
            _buildListOfCategories()
          ],
        ),
      ),
    );
  }

  Widget _buildLocationContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextWithIcon(
            text: translation.location.tr, icon: Icons.location_on_rounded),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
                isDismissible: true,
                Container(
                    padding: const EdgeInsets.all(14),
                    height: 260,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? ColorConstants.darkMainColor
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        )),
                    child: _buildSelectCity()));
          },
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: ColorConstants.lightMainColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(translation.selectCity.tr,
                  style: TextStyle(
                    color:
                        Get.isDarkMode ? Colors.white : ColorConstants.black0,
                    fontSize: 13,
                    fontFamily: 'Noto Kufi Arabic',
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCountryCityContainer() {
    return Obx(
      () => (Controllers.offerController.filterCountryName.value.isNotEmpty &&
              Controllers.offerController.filterCityName.value.isNotEmpty)
          ? Container(
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorConstants.mainColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${Controllers.offerController.filterCountryName.value} [${Controllers.offerController.filterCityName.value}]',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Controllers
                                  .offerController.filterCountryName.value = '';
                              Controllers.offerController.filterCityName.value =
                                  '';
                            },
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: ColorConstants.mainColor,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSelectCity() {
    return ListView(
      children: [
        _buildDropHeader(text: translation.selectCountry.tr),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Utils.drawDropDownListCountriesBtn(
              optionName: translation.selectCountry.tr,
              dropDownValue:
                  Controllers.offerController.filterCountryName.value,
              onChanged: (country) {
                Controllers.offerController.filterCountryName.value =
                    Utils.getTranslatedText(
                        arText: country.arName, enText: country.enName);
                Controllers.offerController.filterCountryId.value =
                    country.id.toString();

                Controllers.userAuthenticationController
                    .getCities(countryId: country.id.toString());

                Controllers.offerController.filterCityId.value = "";
                Controllers.offerController.filterCityName.value = "";
              },
              menu: Controllers.directionalityController.countries,
              context: context,
              iconSize: 34,
              containerBorderColor: ColorConstants.greyColor,
              textColor: ColorConstants.black0),
        ),
        const SizedBox(
          height: 14,
        ),
        _buildDropHeader(text: translation.selectCity.tr),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Utils.drawDropDownListCitiesBtn(
              optionName: translation.selectCity.tr,
              dropDownValue: Controllers.offerController.filterCityName.value,
              onChanged: (city) {
                Controllers.offerController.filterCityName.value =
                    Utils.getTranslatedText(
                        arText: city.arName, enText: city.enName);
                Controllers.offerController.filterCityId.value =
                    city.id.toString();
              },
              menu: Controllers.directionalityController.cities,
              context: context,
              iconSize: 34,
              containerBorderColor: ColorConstants.greyColor,
              textColor: ColorConstants.black0),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _buildDropHeader({required String text}) {
    return Text(text,
        style: TextStyle(
          color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontFamily: 'Noto Kufi Arabic',
        ));
  }

  Widget _buildTextWithIcon({required String text, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorConstants.mainColor,
          size: 19,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(text,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
              fontSize: 15,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w700,
            ))
      ],
    );
  }

  // list of categories
  Widget _buildListOfCategories() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
            itemCount: homeController.subCategories.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return _buildSelectCheckbox(
                  categoryId: homeController.subCategories[index].id.toString(),
                  text: Utils.getTranslatedText(
                      arText: homeController.subCategories[index].arName,
                      enText: homeController.subCategories[index].enName),
                  index: index);
            }),
      ),
    );
  }

  Widget _buildSelectCheckbox(
      {required String categoryId, required String text, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          if (checkedData![index] == text && listId![index] == categoryId) {
            checkedData![index] = '';
            listId![index] = '';
          } else {
            checkedData![index] = text;
            listId![index] = categoryId;
          }
        });
      },
      child: SizedBox(
        height: 60,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
                Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                      color: (checkedData!.isNotEmpty &&
                              checkedData![index] == text)
                          ? ColorConstants.mainColor
                          : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      border: Border.all(
                        color: (checkedData!.isNotEmpty &&
                                checkedData![index] == text)
                            ? ColorConstants.mainColor
                            : ColorConstants.greyColor,
                        width: 1,
                      )),
                  child:
                      // Controllers.sessionQuestionsController.goalReview.value == text ?
                      (checkedData!.isNotEmpty && checkedData![index] == text)
                          ? const Center(
                              child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 14,
                            ))
                          : const SizedBox(),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Divider(
            //     color: ColorConstants.backgroundContainerLightColor,
            //     height: 0.7,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
