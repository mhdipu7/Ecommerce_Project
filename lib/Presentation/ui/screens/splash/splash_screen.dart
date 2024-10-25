import 'package:crafty_bay/Presentation/state_holders/auth/auth/auth_controller.dart';
import 'package:crafty_bay/Presentation/state_holders/internet_connectivity/connectivity_controller.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/app_logo_widget.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final InternetConnectivityController _internetConnectivityController = Get.find<InternetConnectivityController>();

  Future<void> _moveToNextScreen() async {

    while(!_internetConnectivityController.isDeviceConnected){
      await Future.delayed(const Duration(seconds: 1));
    }

    await Future.delayed(const Duration(seconds: 3));
    await Get.find<AuthController>().getAccessToken();
    Get.offNamed(RoutesName.mainBottomNavScreen);
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Version 1.0.0",
                style: TextStyle(color: AppColors.greyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
