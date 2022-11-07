import 'package:flutter/material.dart';
import 'package:tanlants_valley_application/data/controller/home_controller.dart';
import 'package:tanlants_valley_application/utils/constant_utils.dart';
import 'package:provider/provider.dart';
import 'bnb_pages/home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;

    return Consumer<HomeController>(
        builder: (context, homeController, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: homeController.selectPage,
                onTap: (value) {
                  homeController.setSelectedPage(value);
                },
                items: homeController.bnbIcon()
                    .map((e) => BottomNavigationBarItem(icon: e, label: ''))
                    .toList()),
            body: homeController.pages[homeController.selectPage]));
  }
}
