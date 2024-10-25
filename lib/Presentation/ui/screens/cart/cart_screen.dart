import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/cart_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_paths/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/empty_widget.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/cart/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CartListController>()
        .getCartList(token: AuthController.accessToken!);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (dipPop, result) {
        backToHome();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: _buildAppBar(),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          int totalPrice = cartListController.cartList.isNotEmpty
              ? cartListController.cartList
                  .map((item) => int.parse(item.price ?? '0'))
                  .reduce((value, element) => value + element)
              : 0;

          if(cartListController.inProgress){
            return const CenteredCircularProgressIndicator();
          }

          if(cartListController.cartList.isEmpty){
            return const EmptyWidget(message: "Cart product not found.");
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartListController.cartList.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cart: cartListController.cartList[index],
                        );
                      },
                    ),
                  ),
                  _buildPriceAndCheckoutSection(totalPrice),
                ],
              ),
              if (cartListController.inProgress)
                Positioned(
                  child: Lottie.asset(
                    width: 100,
                    AssetsPath.shoppingCart,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPriceAndCheckoutSection(int totalPrice) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Price"),
              Text(
                "\$$totalPrice",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Checkout"),
            ),
          )
        ],
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
      title: const Text("Cart"),
    );
  }

  void backToHome() {
    Get.find<MainBottomNavController>().backToHome();
  }
}
