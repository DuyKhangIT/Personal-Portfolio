import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class DownloadFile {
  static Future<void> downloadPdf(String assetPath, String fileName) async {
    try {
      // Đọc file PDF từ assets
      ByteData data = await rootBundle.load(assetPath);
      Uint8List bytes = data.buffer.asUint8List();

      // Tạo Blob từ dữ liệu file
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Tạo thẻ <a> để tải file
      html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click(); // Kích hoạt tải xuống

      // Giải phóng bộ nhớ
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint("Lỗi: $e");
    }
  }
}
