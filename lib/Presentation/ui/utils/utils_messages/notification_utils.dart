import 'package:another_flushbar/flushbar.dart';
import 'package:crafty_bay/Presentation/ui/utils/colors/app_colors.dart';
import 'package:crafty_bay/app/app.dart';
import 'package:flutter/material.dart';

class NotificationUtils {
  static void flushBarNotification({
    required String title,
    required String message,
    Color backgroundColor = AppColors.themeColor,
  }) {
    BuildContext? context = CraftyBayApp.navigatorKey.currentContext;

    if (context != null) {
      Flushbar(
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(12),
      ).show(context);
    }
  }
}
