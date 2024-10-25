import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/read_profile/read_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/user_profile/update_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/user_profile/user_profile_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/user_profile/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _customerNameTEController =
      TextEditingController();
  final TextEditingController _customerAddressTEController =
      TextEditingController();
  final TextEditingController _customerCityTEController =
      TextEditingController();
  final TextEditingController _customerStateTEController =
      TextEditingController();
  final TextEditingController _customerPostCodeTEController =
      TextEditingController();
  final TextEditingController _customerCountryTEController =
      TextEditingController();
  final TextEditingController _customerPhoneTEController =
      TextEditingController();
  final TextEditingController _customerFaxTEController =
      TextEditingController();
  final TextEditingController _shippingNameTEController =
      TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();
  final TextEditingController _shippingCityTEController =
      TextEditingController();
  final TextEditingController _shippingStateTEController =
      TextEditingController();
  final TextEditingController _shippingPostCodeTEController =
      TextEditingController();
  final TextEditingController _shippingCountryTEController =
      TextEditingController();
  final TextEditingController _shippingPhoneTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateProfileController _updateProfileController =
      Get.find<UpdateProfileController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EditProfileForm(
            formKey: _formKey,
            customerNameTEController: _customerNameTEController,
            customerAddressTEController: _customerAddressTEController,
            customerCityTEController: _customerCityTEController,
            customerStateTEController: _customerStateTEController,
            customerPostCodeTEController: _customerPostCodeTEController,
            customerCountryTEController: _customerCountryTEController,
            customerPhoneTEController: _customerPhoneTEController,
            customerFaxTEController: _customerFaxTEController,
            shippingNameTEController: _shippingNameTEController,
            shippingAddressTEController: _shippingAddressTEController,
            shippingCityTEController: _shippingCityTEController,
            shippingStateTEController: _shippingStateTEController,
            shippingPostCodeTEController: _shippingPostCodeTEController,
            shippingCountryTEController: _shippingCountryTEController,
            shippingPhoneTEController: _shippingPhoneTEController,
          ),
          const SizedBox(height: 16),
          _buildSaveButton(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return GetBuilder<UpdateProfileController>(
        builder: (updateProfileController) {
      return Visibility(
        visible: !updateProfileController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapSaveButton,
          child: const Text("Save"),
        ),
      );
    });
  }

  Future<void> _onTapSaveButton() async {
    if (_formKey.currentState!.validate()) {
      bool isUpdated = await _updateProfileController.updateProfile(
        customerName: _customerNameTEController.text.trim(),
        customerAddress: _customerAddressTEController.text.trim(),
        customerCity: _customerCityTEController.text.trim(),
        customerState: _customerStateTEController.text.trim(),
        customerPostCode: _customerPostCodeTEController.text.trim(),
        customerCountry: _customerCountryTEController.text.trim(),
        customerPhone: _customerPhoneTEController.text.trim(),
        customerFax: _customerFaxTEController.text.trim(),
        shippingName: _shippingNameTEController.text.trim(),
        shippingAddress: _shippingAddressTEController.text.trim(),
        shippingCity: _shippingCityTEController.text.trim(),
        shippingState: _shippingStateTEController.text.trim(),
        shippingPostCode: _shippingPostCodeTEController.text.trim(),
        shippingCountry: _shippingCountryTEController.text.trim(),
        shippingPhone: _shippingPhoneTEController.text.trim(),
        token: AuthController.accessToken!,
      );
      if (isUpdated) {
        await Get.find<ReadProfileController>()
            .getProfileDetails(AuthController.accessToken!);
        Get.find<UserProfileController>().loadUserData();
        _clearTextFormField();
        NotificationUtils.flushBarNotification(
          title: "Congratulations",
          message: "Profile Successfully Updated.",
        );
        debugPrint("Profile successfully updated.");
      } else {
        NotificationUtils.flushBarNotification(
          title: "Warning!",
          message: "Profile update failed! Try again.",
          backgroundColor: AppColors.redColor,
        );
        debugPrint("Profile update failed.");
      }
    } else {
      NotificationUtils.flushBarNotification(
        title: "Warning!",
        message: "You have to complete this update form.",
        backgroundColor: AppColors.redColor,
      );
    }
  }

  void _clearTextFormField() {
    _customerNameTEController.clear();
    _customerAddressTEController.clear();
    _customerCityTEController.clear();
    _customerStateTEController.clear();
    _customerPostCodeTEController.clear();
    _customerCountryTEController.clear();
    _customerPhoneTEController.clear();
    _customerFaxTEController.clear();
    _shippingNameTEController.clear();
    _shippingAddressTEController.clear();
    _shippingCityTEController.clear();
    _shippingStateTEController.clear();
    _shippingPostCodeTEController.clear();
    _shippingCountryTEController.clear();
    _shippingPhoneTEController.clear();
  }

  @override
  void dispose() {
    _customerNameTEController.dispose();
    _customerAddressTEController.dispose();
    _customerCityTEController.dispose();
    _customerStateTEController.dispose();
    _customerPostCodeTEController.dispose();
    _customerCountryTEController.dispose();
    _customerPhoneTEController.dispose();
    _customerFaxTEController.dispose();
    _shippingNameTEController.dispose();
    _shippingAddressTEController.dispose();
    _shippingCityTEController.dispose();
    _shippingStateTEController.dispose();
    _shippingPostCodeTEController.dispose();
    _shippingCountryTEController.dispose();
    _shippingPhoneTEController.dispose();
    super.dispose();
  }
}
