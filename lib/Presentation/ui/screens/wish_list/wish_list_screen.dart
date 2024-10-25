import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/empty_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/wish_list/wish_list_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<WishListController>()
          .getWishList(token: AuthController.accessToken!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (dipPop, result) {
        backToHome();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: GetBuilder<WishListController>(builder: (wishListController) {
          if (wishListController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          if (wishListController.wishList.isEmpty) {
            return const EmptyWidget(
              message: 'Wish product not found.',
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: wishListController.wishList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return WishListProductCard(
                  wishData: wishListController.wishList[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      // leading: IconButton(
      //   onPressed: backToHome,
      //   icon: const Icon(Icons.arrow_back_ios),
      // ),
      automaticallyImplyLeading: false,
      title: const Text("WishList"),
    );
  }

  void backToHome() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
