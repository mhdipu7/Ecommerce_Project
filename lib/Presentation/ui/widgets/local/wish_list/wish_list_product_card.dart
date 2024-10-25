import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/delete_wish_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/unauthorized_warning_message.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:crafty_bay/data/models/wish_list/wish_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListProductCard extends StatelessWidget {
  const WishListProductCard({
    super.key,
    required this.wishData,
  });

  final WishListDataModel wishData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesName.productDetailsScreen,
            arguments: {'productID': wishData.productId!});
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
                    image: NetworkImage(wishData.product?.image ?? ''),
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
                      wishData.product?.title ?? '',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${wishData.product?.price ?? ''}",
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
                              "${wishData.product?.star ?? ''}",
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<DeleteWishListController>(
                            builder: (deleteWishListController) {
                          return InkWell(
                            onTap: () async {
                              await _deleteWishProduct(
                                context: context,
                                controller: deleteWishListController,
                                productID: wishData.productId!,
                              );
                            },
                            child: Card(
                              color: AppColors.themeColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteWishProduct({
    required BuildContext context,
    required DeleteWishListController controller,
    required int productID,
  }) async {
    if (AuthController.accessToken != null) {
      bool isWishProductDeleted = await controller.deleteWishList(
        token: AuthController.accessToken!,
        productID: productID,
      );

      if (isWishProductDeleted) {
        Get.find<WishListController>()
            .getWishList(token: AuthController.accessToken!);
        NotificationUtils.flushBarNotification(
          title: "Congratulations",
          message: "Product successfully deleted wish product.",
        );
      } else {
        NotificationUtils.flushBarNotification(
          title: "Failed",
          message: "WishList delete failed!. Try again.",
          backgroundColor: AppColors.redColor,
        );
      }
    } else {
      unauthorizedWarningMessage();
    }
  }
}
