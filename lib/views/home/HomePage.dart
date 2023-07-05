import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../shared/constants/ColorConstants.dart';

class HomePage extends StatefulWidget {
  Widget recentPage;
  int selectedIndex;
  HomePage({Key? key, required this.recentPage, required this.selectedIndex})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.find();

  void updateTabSelection(int index) {
    setState(() {
      print('index is $index');
      widget.selectedIndex = index;
      widget.recentPage = _homeController.pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          notchMargin: 10,
          child: Container(
              height: 67,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child:
              // Obx(
              //   () =>
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomAppBarItem(
                        icon: Icons.home_rounded,
                        text: translation.offersText.tr,
                        page: 0),
                    _bottomAppBarItem(
                        icon: Icons.shopping_basket,
                        text: translation.ordersText.tr,
                        page: 1),
                    _bottomAppBarItem(
                        icon: Icons.category_rounded,
                        text: translation.categoriesText.tr,
                        page: 2),
                    _bottomAppBarItem(
                        icon: Icons.favorite,
                        text: translation.favouriteText.tr,
                        page: 3),
                    _bottomAppBarItem(
                        icon: Icons.person,
                        text: translation.profileText.tr,
                        page: 4),
                  ],
                ),
              )),
        // ),
        body: widget.recentPage
        //   PageView(
        //     controller: _homeController.pageController,
        //     physics: const NeverScrollableScrollPhysics(),
        //     children: [
        //       ..._homeController.pages
        //     ],
        //
        // ),
        );
  }

  Widget _bottomAppBarItem(
      {required IconData icon, required String text, required int page}) {
    return SizedBox(
      height: 50,
      child: ZoomTapAnimation(
        onTap: () {
          updateTabSelection(page);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: widget.selectedIndex == page
                  ? ColorConstants.mainColor
                  : ColorConstants.navBarIconColor,
              size: 25,
            ),
            Text(
              text,
              style: TextStyle(
                  color:widget.selectedIndex == page
                  // _homeController.currentPage == page
                      ? ColorConstants.mainColor
                      : ColorConstants.navBarIconColor,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
