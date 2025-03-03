import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenWeb {
  static void openURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      debugPrint("Không thể mở URL: $url");
    }
  }
}
