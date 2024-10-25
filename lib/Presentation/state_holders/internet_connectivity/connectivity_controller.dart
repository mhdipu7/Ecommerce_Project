import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crafty_bay/Presentation/ui/widgets/global/internet_status_dialog_box.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivityController extends GetxController {
  late StreamSubscription _streamSubscription;
  bool isDeviceConnected = false;
  bool isAlert = false;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
  }

  void _checkConnectivity() {
    try {
      _streamSubscription = Connectivity().onConnectivityChanged.listen(
        (result) async {
          try {
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && !isAlert) {
              internetStatusDialogBox(_handleRetry);
              isAlert = true;
            } else if(isDeviceConnected){
              isAlert = false;
              Get.offNamed(RoutesName.mainBottomNavScreen);
            }
          } catch (e) {
            debugPrint("Error checking internet connection: $e");
          }
        },
      );
    } catch (e) {
      debugPrint("Error listening to connectivity changes: $e");
    }
  }

  void _handleRetry() async {
    try {
      Get.back();
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        internetStatusDialogBox(_handleRetry);
      } else {
        isAlert = false;
        Get.offNamed(RoutesName.mainBottomNavScreen);
      }
    } catch (e) {
      debugPrint("Error during retry internet connection check: $e");
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}
