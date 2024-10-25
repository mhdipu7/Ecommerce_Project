import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/data/models/user/user_model.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  UserModel? user;

  Future<void> loadUserData() async {
    user = await AuthController.getUserData();
    update();
  }
}
