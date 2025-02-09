import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class AppPlatform {
  static const bool isWeb = kIsWeb;
  static final bool isIOS = !isWeb && Platform.isIOS;
  static final bool isAndroid = !isWeb && Platform.isAndroid;
  static final bool isTest =
      !isWeb && Platform.environment.containsKey('FLUTTER_TEST');

  AppPlatform._();
}
