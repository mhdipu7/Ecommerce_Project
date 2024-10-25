import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static const _initialSeconds = 120;
  int _remainingSeconds = _initialSeconds;
  Timer? _timer;

  int get remainingSeconds => _remainingSeconds;

  bool get isTimerActive => _timer != null && _timer!.isActive;

  void startTimer() {
    if (isTimerActive) return;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          update();
        } else {
          _stopTimer();
        }
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }

  void resetTimer({required VoidCallback resendCode}) {
    resendCode();
    _stopTimer();
    _remainingSeconds = _initialSeconds;
    startTimer();
  }
}
