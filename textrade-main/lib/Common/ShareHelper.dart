import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../Common/Utilies.dart';
class ShareHelper {
  /// Universal helper to share multiple files (iOS-safe).
  static Future<void> shareFilesUniversal(List<XFile> xFiles, {String text = ''}) async {
    if (xFiles.isEmpty) {
      debugPrint('shareFilesUniversal: no files to share');
      return;
    }

    try {
      BuildContext? ctx = Get.context;
      Rect origin;

      if (ctx != null) {
        try {
          final media = MediaQuery.of(ctx);
          origin = Rect.fromLTWH(
            (media.size.width / 2) - 50,
            (media.size.height / 2) - 50,
            100,
            100,
          );
        } catch (_) {
          origin = const Rect.fromLTWH(100, 100, 200, 200);
        }
      } else {
        origin = const Rect.fromLTWH(100, 100, 200, 200);
      }

      // Primary attempt: provide origin (needed on iPad)
      await Share.shareXFiles(xFiles, sharePositionOrigin: origin, text: text);
    } catch (e) {
      debugPrint('Share with origin failed: $e — trying fallback without origin');
      try {
        await Share.shareXFiles(xFiles, text: text);
      } catch (e2) {
        debugPrint('Fallback share also failed: $e2');
        Utility.showErrorView("Alert!", "Unable to share file.");
      }
    }
  }
}
