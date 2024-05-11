import 'dart:io';

class AppConfig {
  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return '10.0.2.2';
    } else if (Platform.isIOS) {
      return 'localhost';
    } else {
      return 'localhost';
    }
  }
}
