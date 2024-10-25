import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/cart_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/delete_cart_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_details/add_to_cart_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/assets_paths/assets_path.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/quantity_counter.dart';
import 'package:crafty_bay/data/models/cart_list/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.cart,
  });

  final CartModel cart;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cart.cartProduct!.title ?? 'Unknown Title',
                            style: textTheme.bodyLarge,
                          ),
                          _buildColorAndSize(textTheme)
                        ],
                      ),
                    ),
                    _buildDeletionButton(),
                  ],
                ),
                _buildPriceAndQuantityCounter(textTheme)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDeletionButton() {
    return IconButton(
      onPressed: _deleteCartItem,
      icon: const Icon(
        Icons.delete,
        color: Colors.grey,
      ),
    );
  }

  void _deleteCartItem() {
    Get.find<DeleteCartListController>().deleteCartList(
      token: AuthController.accessToken!,
      productID: widget.cart.productId!,
    );
    Get.find<CartListController>()
        .getCartList(token: AuthController.accessToken!);
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        AssetsPath.dummyImage,
        height: 80,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
      spacing: 8,
      children: [
        Text(
          "Color: ${widget.cart.color ?? 'Unknown'}",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        Text(
          "Size: ${widget.cart.size ?? 'Unknown'}",
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantityCounter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$${widget.cart.price ?? '0'}",
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.themeColor,
          ),
        ),
        QuantityCounter(
          quantity: int.tryParse(widget.cart.qty ?? '0') ?? 0,
          onIncrease: () {
            int qty = int.tryParse(widget.cart.qty ?? '') ?? 0;
            qty++;
            _updateCartQuantity(qty);
          },
          onDecrease: () {
            int qty = int.tryParse(widget.cart.qty ?? '') ?? 0;
            if (qty > 1) {
              qty--;
              _updateCartQuantity(qty);
            }
          },
        ),
      ],
    );
  }

  void _updateCartQuantity(int qty) {
    Get.find<AddToCartController>().addToCart(
      productID: widget.cart.productId!,
      color: widget.cart.color ?? 'unknown',
      size: widget.cart.size ?? 'unknown',
      quantity: qty,
    );
    Get.find<CartListController>()
        .getCartList(token: AuthController.accessToken!);
  }
}
