// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test_ecommerce_app/models/categories/sub_categories/SubCategoriesModel.dart';
// import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
// import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
// import 'package:test_ecommerce_app/shared/shared_preferences.dart';
// import 'package:test_ecommerce_app/shared/utils.dart';
// import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
//
// class SubCategoryPage extends StatelessWidget {
//   final String subCategoryName;
//   final List<SubCategoriesModel> categories;
//   const SubCategoryPage({Key? key,required this.subCategoryName,required this.categories}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: Utils.direction,
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar:  AppBar(
//             elevation: 0,
//             backgroundColor: ColorConstants.backgroundContainer,
//             toolbarHeight: 78,
//             leading:  _buildLeadingAppBar() ,leadingWidth: 260,
//             actions:[ Padding(
//               padding: EdgeInsets.only(
//                   right: SharedPreferencesClass.getLanguageCode() == 'ar' ? 0 : 16,
//                   left: SharedPreferencesClass.getLanguageCode() == 'ar' ? 16 : 0),
//               child: _buildActionsAppBar(context: context),
//             )],
//
//           ),
//           body: Obx(() => (categories.isNotEmpty)
//               ? ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               scrollDirection: Axis.vertical,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   width: 210,
//                   child: GestureDetector(
//                     onTap: () {
//                       // controller.getOffersForSubCategories(
//                       //   subCategoryId:
//                       //   controller.subCategories[index].id.toString(),
//                       // );
//                       // Get.to(() => OfferListForSubCategoryPage(
//                       //   mainCategoryName:
//                       //   controller.subCategories[index].enName,));
//                     },
//                     child: Container(
//                         clipBehavior: Clip.hardEdge,
//                         margin: const EdgeInsets.only(right: 8),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Get.isDarkMode
//                               ? ColorConstants.gray700
//                               : Colors.grey.shade200,
//                           border: Border.all(
//                               color: Get.isDarkMode
//                                   ? Colors.transparent
//                                   : Colors.grey.shade200,
//                               width: 1),
//                         ),
//                         child: Stack(
//                           children: [
//                             SizedBox(
//                               height: 210,
//                               width: double.infinity,
//                               child: CachedNetworkImage(
//                                 imageUrl: ApiConstants.storageURL +
//                                     categories[index].imageUrl
//                                         .toString(),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                                 top: 0,
//                                 left: 0,
//                                 right: 0,
//                                 bottom: 0,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.black.withAlpha(110),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: 17,
//                                       bottom: 8,
//                                       right: 17,
//                                     ),
//                                     child: Align(
//                                       alignment: SharedPreferencesClass
//                                           .getLanguageCode() ==
//                                           'ar'
//                                           ? Alignment.bottomRight
//                                           : Alignment.bottomLeft,
//                                       child: SizedBox(
//                                         height: 28,
//                                         child: Text(
//                                             SharedPreferencesClass
//                                                 .getLanguageCode() ==
//                                                 'ar'
//                                                 ?categories[index]
//                                                 .arName
//                                                 .toString()
//                                                 : categories[index]
//                                                 .enName
//                                                 .toString(),
//                                             style: Theme.of(context).textTheme.headline6!
//                                                 .copyWith(
//                                                 fontSize: 13.0,
//                                                 fontWeight:
//                                                 FontWeight.w600,
//                                                 color: Colors.white)),
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                           ],
//                         )),
//                   ),
//                 );
//               })
//               : ShimmerContainer(
//               width: MediaQuery.of(context).size.width,
//               height: 110,
//               topPadding: 0,
//               bottomPadding: 0,
//               rightPadding: 0,
//               leftPadding: 0),)));
//
//   }
//
//   Widget _buildActionsAppBar({required BuildContext context}) {
//     return
//       Row(
//         children: [
//           appBarIcon(icon: Icons.search, iconColor: ColorConstants.mainColor),
//           const SizedBox(
//             width: 8,
//           ),
//           appBarIcon(
//               icon: Icons.notifications, iconColor: ColorConstants.mainColor),
//           const SizedBox(
//             width: 8,
//           ),
//           appBarIcon(
//               icon: Icons.shopping_cart_rounded,
//               iconColor: ColorConstants.mainColor),
//         ],
//
//       );
//   }
//
//   Widget _buildLeadingAppBar(){
//     return  Padding(
//       padding: EdgeInsets.only(
//           right: SharedPreferencesClass.getLanguageCode() == 'ar' ? 16 : 0,
//           left: SharedPreferencesClass.getLanguageCode() == 'ar' ? 16 : 0),
//       child: GestureDetector(
//         onTap: () {
//           Get.back();
//         },
//         child: Row(
//           children: [
//             Container(
//               width: 37,
//               height: 37,
//               decoration: const BoxDecoration(
//                 color: ColorConstants.mainColor,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.arrow_back_ios_rounded,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               subCategoryName,
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontFamily: 'Noto Kufi Arabic',
//                   fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget appBarIcon({required IconData icon, required Color iconColor}) {
//     return Icon(
//       icon,
//       color: iconColor,
//       size: 25,
//     );
//   }
//
// }
//
