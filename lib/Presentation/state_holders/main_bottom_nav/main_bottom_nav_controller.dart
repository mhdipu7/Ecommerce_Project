import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/cart/cart_list_controller.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/unauthorized_warning_message.dart';
import 'package:crafty_bay/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainBottomNavController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    BuildContext? context = CraftyBayApp.navigatorKey.currentContext;
    if (index == 2 || index == 3) {
      if (AuthController.accessToken != null) {
        Get.find<CartListController>()
            .getCartList(token: AuthController.accessToken!);
        _selectedIndex = index;
      } else {
        if (context != null) {
          unauthorizedWarningMessage();
        }
      }
    } else {
      _selectedIndex = index;
    }
    update();
  }

  void selectCategory() {
    changeIndex(1);
  }

  void backToHome() {
    changeIndex(0);
  }
}
