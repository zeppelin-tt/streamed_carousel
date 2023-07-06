import 'dart:io';

import 'package:flutter/services.dart';

/// TODO Переписать на интерфейс и реализации. Статические методы не тестируемы
class VibrationService {
  static Future<void> lightImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.lightImpact();
    } else {
      await HapticFeedback.vibrate();
    }
  }

  static Future<void> mediumImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.mediumImpact();
    } else {
      await HapticFeedback.vibrate();
    }
  }

  static Future<void> heavyImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.heavyImpact();
    } else {
      await HapticFeedback.vibrate();
    }
  }

  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }

  static Future<void> selectionClick() async {
    if (Platform.isIOS) {
      await HapticFeedback.selectionClick();
    } else {
      await HapticFeedback.vibrate();
    }
  }
}
