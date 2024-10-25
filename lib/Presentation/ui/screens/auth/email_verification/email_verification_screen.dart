import 'package:crafty_bay/Presentation/state_holders/auth/email_verification/email_verification_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/auth_header.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/email_verification/email_verification_form.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 82),
              const AuthHeader(
                title: "Welcome Back",
                subTitle: "Please enter your email address.",
              ),
              const SizedBox(height: 16),
              EmailVerificationForm(
                formKey: _formKey,
                emailTEController: _emailTEController,
              ),
              const SizedBox(height: 16),
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return GetBuilder<EmailVerificationController>(
        builder: (emailVerificationController) {
      return Visibility(
        visible: !_emailVerificationController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Text('Next'),
        ),
      );
    });
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    bool result = await _emailVerificationController.verifyEmail(
      _emailTEController.text.trim(),
    );

    if (result) {
      Get.toNamed(
        RoutesName.otpVerificationScreen,
        arguments: {
          'email': _emailTEController.text.trim(),
        },
      );
    } else {
      NotificationUtils.flushBarNotification(
        title: "Email Verification Alert!",
        message: _emailVerificationController.errorMessage!,
        backgroundColor: AppColors.redColor,
      );
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
