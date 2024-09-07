import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';

class Logger {
  static void info(String message) {
    if (kDebugMode) {
      _print(message, color: Colors.green, platform: _getPlatform());
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      _print(message, color: Colors.red, platform: _getPlatform());
    }
  }

  static void success(String message) {
    if (kDebugMode) {
      _print(message, color: Colors.blue, platform: _getPlatform());
    }
  }

  static void _print(String message, {required Color color, required String platform}) {
    if (platform == 'web') {
      _printWeb(message, color);
    } else {
      _printNative(message, color);
    }
  }

  static void _printWeb(String message, Color color) {
    final colorCode = colorToHex(color);
    // Here you might want to use a web-specific logging mechanism or handle this differently
    // Example: using `console.log` with HTML color formatting
    print('<span style="color: #$colorCode;">$message</span>'); // Example for web
  }

  static void _printNative(String message, Color color) {
    final colorCode = colorToHex(color);
    // Use ANSI color codes for terminal output
    print('\x1B[38;2;${color.red};${color.green};${color.blue}m$message\x1B[0m');
  }

  static String _getPlatform() {
    if (kIsWeb) return 'web';
    return 'native';
  }

  static String colorToHex(Color color) {
    return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
