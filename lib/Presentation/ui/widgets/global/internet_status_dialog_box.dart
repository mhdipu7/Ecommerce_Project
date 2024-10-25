import 'package:flutter/material.dart';
import 'package:get/get.dart';

void  internetStatusDialogBox(VoidCallback onPressed) {
  Get.dialog(
    AlertDialog(
      title: const Text("No Internet Connection"),
      content: const Text(
          "It looks like you're not connected to the internet. Please check your connection to continue using the app."),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text("Got it"),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}