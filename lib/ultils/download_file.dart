import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class DownloadFile {
  static Future<void> downloadPdf(String assetPath, String fileName,
      {BuildContext? context}) async {
    try {
      // Read the PDF file from assets
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();

      // Create a blob from file data
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Detect if running on mobile browser
      final bool isMobile = html.window.navigator.userAgent
              .toLowerCase()
              .contains('mobile') ||
          html.window.navigator.userAgent.toLowerCase().contains('android') ||
          html.window.navigator.userAgent.toLowerCase().contains('iphone');

      if (isMobile) {
        // Mobile browser approach - open in new tab first
        // This works better on iOS Safari and mobile Chrome
        final newWindow = html.window.open(url, '_blank');

        // If popup was blocked or failed, fall back to direct download
        if (newWindow.closed == true) {
          _directDownload(url, fileName);
        } else {
          // After opening in new tab, try to trigger download
          // Use timeout to ensure tab has loaded
          Future.delayed(const Duration(milliseconds: 500), () {
            try {
              // For iOS Safari - let user view the PDF first, then they can use share sheet
              if (html.window.navigator.userAgent
                      .toLowerCase()
                      .contains('iphone') ||
                  html.window.navigator.userAgent
                      .toLowerCase()
                      .contains('ipad')) {
                // iOS devices will show the PDF and user can save from there
                if (context != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("PDF opened. Use the share button to save it."),
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              } else {
                // For Android, attempt to trigger download in the new tab
                js.context.callMethod('eval', [
                  '''
                setTimeout(function() {
                  var link = document.createElement('a');
                  link.href = "$url";
                  link.download = "$fileName";
                  link.click();
                }, 300);
              '''
                ]);
              }
            } catch (e) {
              debugPrint("Secondary download attempt failed: $e");
            }
          });
        }
      } else {
        // Desktop browser - use standard download approach
        _directDownload(url, fileName);
      }

      // Clean up the object URL after a delay
      // This delay ensures download has time to start
      Future.delayed(const Duration(seconds: 2), () {
        html.Url.revokeObjectUrl(url);
      });
    } catch (e) {
      debugPrint("Download error: $e");
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Could not download PDF: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Helper method for direct download using an anchor element
  static void _directDownload(String url, String fileName) {
    // Create anchor element to trigger download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..style.display = 'none';

    // Add to document, click, and remove
    html.document.body!.children.add(anchor);
    anchor.click();

    // Use a slight delay before removing to ensure download starts
    Future.delayed(const Duration(milliseconds: 100), () {
      anchor.remove();
    });
  }

  /// Fallback for situations where direct download doesn't work
  /// Opens a dialog showing how to save the PDF manually
  static void showPdfInDialog(
      BuildContext context, Uint8List pdfData, String fileName) {
    // Register view factory for PDF viewer
    final String viewId = 'pdf-viewer-${DateTime.now().millisecondsSinceEpoch}';

    // Create a Blob URL from the PDF data
    final blob = html.Blob([pdfData], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create iframe to show PDF
    platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final iframe = html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
      return iframe;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save $fileName'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const Text(
                'Long-press the PDF below and select "Download" or "Save" from your browser menu.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: HtmlElementView(viewType: viewId),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              html.Url.revokeObjectUrl(url);
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
