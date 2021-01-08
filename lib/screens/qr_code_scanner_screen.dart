import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/rounded_button.dart';

class QrCodeScannerScreen extends StatefulWidget {
  static String id = "qr_code_scanner";

  @override
  _QrCodeScannerScreenState createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  String qrCodeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 40.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
            ),
            Text(
              'Scan QR Code',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedButton(
              text: 'Open Camera',
              color: Colors.green[900],
              onPressed: () async {
                String codeScanner = await BarcodeScanner.scan();
                setState(() {
                  // TODO: Send data to Record Verification or
                  qrCodeResult = codeScanner;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
