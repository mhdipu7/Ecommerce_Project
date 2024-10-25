import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/complete_profile/create_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/create_review/create_product_review_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/email_verification/email_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/otp_verification/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/otp_verification/timer_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/read_profile/read_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/user_profile/update_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/user_profile/user_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/cart_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/delete_cart_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/category/category_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/new_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/popular_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/slider_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/category/list_product_by_category_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/internet_connectivity/connectivity_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_details/add_to_cart_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/product_details/product_details_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/review/product_review_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/home/special_product_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/create_wish_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/delete_wish_list_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/wish_list/wish_list_controller.dart';
import 'package:crafty_bay/data/services/logger_service.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {

    /// internet connectivity
    Get.put(InternetConnectivityController());

    /// Logger setup
    Get.put(Logger());
    Get.put(LoggerService(logger: Get.find<Logger>()));

    /// NetworkCaller with LoggerService
    Get.put(AuthController());
    Get.put(NetworkCaller(
      loggerServices: Get.find<LoggerService>(),
      authController: Get.find<AuthController>(),
    ));

    /// State holders
    Get.put(MainBottomNavController());
    Get.put(TimerController());
    Get.put(SliderListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(ListProductByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(CreateProfileController());
    Get.put(ReadProfileController());
    Get.put(UserProfileController());
    Get.put(UpdateProfileController());
    Get.put(CreateProductReviewController());
    Get.put(ProductReviewController());
    Get.put(CartListController());
    Get.put(DeleteCartListController());
    Get.put(WishListController());
    Get.put(CreateWishListController());
    Get.put(DeleteWishListController());
  }
}
