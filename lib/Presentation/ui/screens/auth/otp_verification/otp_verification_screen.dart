import 'package:crafty_bay/Presentation/state_holders/auth/email_verification/email_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/otp_verification/otp_verification_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/otp_verification/timer_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/auth/read_profile/read_profile_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/utils/utils_messages/notification_utils.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/auth_header.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/Presentation/ui/widgets/local/otp_verification/otp_verification_form.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  final TimerController _timerController = Get.put(TimerController());

  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();

  final ReadProfileController _readProfileController =
      Get.find<ReadProfileController>();

  @override
  void initState() {
    super.initState();
    _timerController.startTimer();
  }

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
                title: "Enter OTP Code",
                subTitle: "A 4 digit otp code has been sent to email.",
              ),
              const SizedBox(height: 24),
              OtpVerificationForm(otpTEController: _otpTEController),
              const SizedBox(height: 16),
              _buildNextButton(),
              const SizedBox(height: 16),
              _buildOtpFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFooter(BuildContext context) {
    return Column(
      children: [
        _buildOtpTimeCounter(context),
        const SizedBox(height: 8),
        _buildOtpResendButton(),
      ],
    );
  }

  Widget _buildOtpResendButton() {
    return GetBuilder<TimerController>(
      builder: (timerController) {
        return TextButton(
          onPressed: timerController.remainingSeconds > 0
              ? null
              : () => timerController.resetTimer(resendCode: _resendCode),
          child: Text(
            "Resend Code",
            style: TextStyle(
              color: timerController.remainingSeconds > 0 ? Colors.grey : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpTimeCounter(BuildContext context) {
    return GetBuilder<TimerController>(
      builder: (timerController) {
        return RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.greyColor),
            text: "This code will expire in ",
            children: [
              TextSpan(
                text: timerController.remainingSeconds.toString(),
                style: const TextStyle(color: AppColors.themeColor),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNextButton() {
    return GetBuilder<OtpVerificationController>(
        builder: (otpVerificationController) {
      return Visibility(
        visible: !otpVerificationController.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: ElevatedButton(
          onPressed: _onTapNextScreen,
          child: const Text('Next'),
        ),
      );
    });
  }

  Future<void> _onTapNextScreen() async {
    bool result = await _otpVerificationController.verifyOtp(
      Get.arguments['email'],
      _otpTEController.text,
    );

    if (result) {
      final bool readProfileResult = await _readProfileController
          .getProfileDetails(_otpVerificationController.accessToken);
      if (readProfileResult) {
        if (_readProfileController.isProfileCompleted) {
          Get.offAllNamed(RoutesName.mainBottomNavScreen);
        } else {
          Get.toNamed(
            RoutesName.completeProfileScreen,
            arguments: {
              'token': _otpVerificationController.accessToken,
            },
          );
        }
      } else {
        NotificationUtils.flushBarNotification(
          title: "Warning",
          message: _readProfileController.errorMessage!,
          backgroundColor: AppColors.redColor,
        );
      }
    } else {
      NotificationUtils.flushBarNotification(
        title: "OTP Verification Alert!",
        message: _otpVerificationController.errorMessage!,
        backgroundColor: AppColors.redColor,
      );
    }
  }

  Future<void> _resendCode() async {
    await Get.find<EmailVerificationController>().verifyEmail(
      Get.arguments['email'],
    );
  }

  @override
  void dispose() {
    _timerController.onClose();
    super.dispose();
  }
}
