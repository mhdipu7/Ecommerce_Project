import 'package:crafty_bay/Presentation/state_holders/auth/complete_profile/create_profile_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/read_profile/read_profile_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/auth_header.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/complete_profile/complete_profile_form/complete_profile_form.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  final CreateProfileController _createProfileController =
      Get.find<CreateProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const AuthHeader(
                title: "Complete Profile",
                subTitle: "Get started with us by providing your information.",
              ),
              CompleteProfileForm(
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
              _buildCompleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteButton() {
    return GetBuilder<CreateProfileController>(
        builder: (createProfileController) {
      return Visibility(
        visible: !createProfileController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapCompleteButton,
          child: const Text('Complete'),
        ),
      );
    });
  }

  Future<void> _onTapCompleteButton() async {
    if (_formKey.currentState!.validate()) {
      bool isCreated = await _createProfileController.createProfile(
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
        token: Get.arguments['token'],
      );
      if (isCreated) {
        await Get.find<ReadProfileController>()
            .getProfileDetails(Get.arguments['token']);
        Get.toNamed(RoutesName.mainBottomNavScreen);
        NotificationUtils.flushBarNotification(
          title: "Congratulations",
          message: "Profile Successfully Completed",
        );
      } else {
        NotificationUtils.flushBarNotification(
          title: "Warning!",
          message: "Profile create failed! Try again.",
          backgroundColor: AppColors.redColor,
        );
      }
    }
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
