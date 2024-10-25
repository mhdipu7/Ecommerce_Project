import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/create_wish_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/delete_wish_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/unauthorized_warning_message.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:crafty_bay/data/models/product/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CreateWishListController _createWishListController =
      Get.find<CreateWishListController>();
  final DeleteWishListController _deleteWishListController =
      Get.find<DeleteWishListController>();

  bool _isAddedWishProduct = false;

  @override
  void initState() {
    super.initState();

    if (AuthController.accessToken != null) {
      Get.find<WishListController>()
          .getWishList(token: AuthController.accessToken!);
      _checkIfProductIsInWishList();
    }
  }

  void _checkIfProductIsInWishList() {
    _createWishListController.isAddedWishProduct(widget.product.id!);
    setState(() {
      _isAddedWishProduct = _createWishListController.isProductAdded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesName.productDetailsScreen,
            arguments: {'productID': widget.product.id!});
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: SizedBox(
          width: 160,
          child: Column(
            children: [
              Container(
                width: 160,
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image ?? ''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.product.title ?? '',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.product.price ?? ''}",
                          style: const TextStyle(
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              "${widget.product.star ?? ''}",
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            if (_isAddedWishProduct == false) {
                              await _addWishList(
                                context: context,
                                controller: _createWishListController,
                                productID: widget.product.id!,
                              );
                            } else {
                              await _deleteWishList(
                                context: context,
                                controller: _deleteWishListController,
                                productID: widget.product.id!,
                              );
                            }
                          },
                          child: Card(
                            color: AppColors.themeColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                _isAddedWishProduct
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addWishList({
    required BuildContext context,
    required CreateWishListController controller,
    required int productID,
  }) async {
    if (AuthController.accessToken != null) {
      try {
        bool isAddedWishList = await controller.createWishList(
          token: AuthController.accessToken!,
          productID: productID,
        );

        if (isAddedWishList) {
          setState(() {
            _isAddedWishProduct = true;
          });

          NotificationUtils.flushBarNotification(
            title: "Congratulations",
            message: "Product successfully added to wish list.",
          );
        } else {
          NotificationUtils.flushBarNotification(
            title: "Failed",
            message: "Wish product added failed. Try again.",
            backgroundColor: AppColors.redColor,
          );
        }
      } catch (e) {
        NotificationUtils.flushBarNotification(
            title: "Error",
            message: "An unexpected error: $e",
            backgroundColor: AppColors.redColor);
      }
    } else {
      unauthorizedWarningMessage();
    }
  }

  Future<void> _deleteWishList({
    required BuildContext context,
    required DeleteWishListController controller,
    required int productID,
  }) async {
    if (AuthController.accessToken != null) {
      try {
        bool isDeletedWishList = await controller.deleteWishList(
          token: AuthController.accessToken!,
          productID: productID,
        );

        if (isDeletedWishList) {
          setState(() {
            _isAddedWishProduct = false;
          });

          NotificationUtils.flushBarNotification(
            title: "Congratulations",
            message: "Product successfully deleted from wish list.",
          );
        } else {
          NotificationUtils.flushBarNotification(
              title: "Failed",
              message: "Wish product deleted failed! Try again.",
              backgroundColor: AppColors.redColor);
        }
      } catch (e) {
        NotificationUtils.flushBarNotification(
            title: "Error",
            message: "An unexpected error: $e",
            backgroundColor: AppColors.redColor);
      }
    } else {
      unauthorizedWarningMessage();
    }
  }
}
