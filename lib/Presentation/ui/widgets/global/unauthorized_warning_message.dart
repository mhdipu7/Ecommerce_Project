import 'package:crafty_bay/app/app.dart';
import 'package:crafty_bay/app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void unauthorizedWarningMessage() {
  BuildContext? context = CraftyBayApp.navigatorKey.currentContext;
  if (context != null) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Warning!")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Now, You are an unauthorized user. You have to create your account and complete your profile.",
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    Get.toNamed(RoutesName.emailVerificationScreen),
                child: const Text("Create Account"),
              ),
            ],
          ),
        );
      },
    );
  }
}
