import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';

// enum ComingSortedByRoute { mainCategory, subCategory }

class SortedBy extends StatefulWidget {
  // final ComingSortedByRoute comingSortedByRoute;
  const SortedBy({
    Key? key,
  }) : super(key: key);

  @override
  State<SortedBy> createState() => _SortedByState();
}

class _SortedByState extends State<SortedBy> {
  int selectedIndex = -1; // Track the index of the selected item

  final List<Map<String, dynamic>> sortedByList = [
    {
      'arName': 'أقوى العروض',
      'enName': 'Hot Offers',
    },
    {
      'arName': 'الأقرب إليك',
      'enName': 'Closest to you',
    },
    {
      'arName': 'العروض الجديدة',
      'enName': 'New offers',
    },
    {
      'arName': 'الأكثر مبيعاً',
      'enName': 'Most seller',
    },
    {
      'arName': 'السعر: من الأقل للأعلى',
      'enName': 'Price: low to high',
    },
    {
      'arName': 'السعر: من الأعلى للأقل',
      'enName': 'Price: high to low',
    },
    {
      'arName': 'الأعلى تقييماً',
      'enName': 'Highest rated',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 14, left: 5),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              height: 7,
              width: 100,
              decoration: BoxDecoration(
                  color: ColorConstants.backgroundContainerLightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(4))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'الترتيب حسب',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white
                            : ColorConstants.black0),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 11),
                //   child: GestureDetector(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: Container(
                //       width: 25,
                //       height: 25,
                //       decoration: const BoxDecoration(
                //         color: ColorConstants.mainColor,
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(
                //         Icons.close_rounded,
                //         color: Colors.white,
                //         size: 17,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: sortedByList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _buildListTileCard(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTileCard({
    required int index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
          Controllers.offerController.filteredListOfferMainCategory
              .sort((a, b) {
            if (sortedByList[index]['enName'] == 'Hot Offers') {
              return a.isSpecialOffer! ? -1 : 1;
            } else if (sortedByList[index]['enName'] == 'Closest to you') {
              return a.isNewest! ? -1 : 1;
            } else if (sortedByList[index]['enName'] == 'New offers') {
              return a.isTodayOffer! ? -1 : 1;
            } else if (sortedByList[index]['enName'] == 'Most seller') {
              return a.isMostSales! ? -1 : 1;
            } else if (sortedByList[index]['enName'] == 'Price: low to high') {
              return a.priceAfterDiscount!.compareTo(b.priceAfterDiscount!);
            } else if (sortedByList[index]['enName'] == 'Price: high to low') {
              return b.priceAfterDiscount!.compareTo(a.priceAfterDiscount!);
            } else if (sortedByList[index]['enName'] == 'Highest rated') {
              return b.offerRate!.compareTo(a.offerRate!);
            }
            return 0;
          });
          // }
        });
        print('selected element ${sortedByList[index]}');
      },
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.getTranslatedText(
                    arText: sortedByList[index]['arName'],
                    enText: sortedByList[index]['enName'],
                  ),
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
                Radio<int>(
                  value: index,
                  activeColor: ColorConstants.mainColor,
                  groupValue: selectedIndex,
                  onChanged: (int? value) {
                    setState(() {
                      selectedIndex = index; // Update the selected index
                      Controllers.offerController.filteredListOfferMainCategory
                          .sort((a, b) {
                        if (sortedByList[index]['enName'] == 'Hot Offers') {
                          return a.isSpecialOffer! ? -1 : 1;
                        } else if (sortedByList[index]['enName'] ==
                            'Closest to you') {
                          return a.isNewest! ? -1 : 1;
                        } else if (sortedByList[index]['enName'] ==
                            'New offers') {
                          return a.isTodayOffer! ? -1 : 1;
                        } else if (sortedByList[index]['enName'] ==
                            'Most seller') {
                          return a.isMostSales! ? -1 : 1;
                        } else if (sortedByList[index]['enName'] ==
                            'Price: low to high') {
                          return a.priceAfterDiscount!
                              .compareTo(b.priceAfterDiscount!);
                        } else if (sortedByList[index]['enName'] ==
                            'Price: high to low') {
                          return b.priceAfterDiscount!
                              .compareTo(a.priceAfterDiscount!);
                        } else if (sortedByList[index]['enName'] ==
                            'Highest rated') {
                          return b.offerRate!.compareTo(a.offerRate!);
                        }
                        return 0;
                      });
                      // }
                    });
                    print('selected element ${sortedByList[index]}');
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: ColorConstants.backgroundContainerLightColor,
                height: 0.7,
              ),
            )
          ],
        ),
      ),
    );
  }
}
