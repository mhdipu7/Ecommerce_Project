import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/category/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/new_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/popular_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/special_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/screens/cart/cart_screen.dart';
import 'package:crafty_bay/Presentation/ui/screens/category/category_list_screen.dart';
import 'package:crafty_bay/Presentation/ui/screens/home/home_screen.dart';
import 'package:crafty_bay/Presentation/ui/screens/wish_list/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final MainBottomNavController _mainBottomNavController =
      Get.find<MainBottomNavController>();

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SliderListController>().getSliderList();
      Get.find<CategoryListController>().getCategoryList();
      Get.find<NewProductListController>().getNewProductList();
      Get.find<PopularProductListController>().getPopularProductList();
      Get.find<SpecialProductListController>().getSpecialProductList();
      if(AuthController.accessToken != null){
        Get.find<WishListController>().getWishList(token: AuthController.accessToken!);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (_) {
        return Scaffold(
          body: _screens[_mainBottomNavController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _mainBottomNavController.selectedIndex,
            onDestinationSelected: _mainBottomNavController.changeIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.category), label: "Category"),
              NavigationDestination(
                  icon: Icon(Icons.shopping_cart), label: "Cart"),
              NavigationDestination(
                  icon: Icon(Icons.favorite_outline), label: "WishList"),
            ],
          ),
        );
      },
    );
  }
}
