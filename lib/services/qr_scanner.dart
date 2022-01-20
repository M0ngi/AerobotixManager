import 'package:flutter/material.dart';
import 'package:manager/widgets/qr_widget.dart';

class QRScanner {
  static Future<dynamic> scanQR(context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => const QRViewExample(),
      ),
    );
  }
}
