import 'package:flutter/material.dart';
import 'package:personal_portfolio/pages/widgets/milk_ui.dart';
import 'package:personal_portfolio/ultils/download_file.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PillButton(
      label: 'Download CV',
      icon: Icons.south_rounded,
      onTap: () {
        DownloadFile.downloadPdf(
          'assets/images/pdf/HuynhDuyKhang_FlutterEngineer.pdf',
          'Huynh Duy Khang - Mobile Developer (Flutter).pdf',
        );
      },
    );
  }
}
