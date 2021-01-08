import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  final String appBarTitle;
  final qrCodeData;

  QrCodeScreen({
    @required this.appBarTitle,
    @required this.qrCodeData,
  });

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
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
              this.widget.appBarTitle,
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
        color: Colors.green[50],
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: QrImage(
              data: this.widget.qrCodeData,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              gapless: true,
              foregroundColor: Colors.black,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.width / 1.25,
            ),
          ),
        ),
      ),
    );
  }
}
