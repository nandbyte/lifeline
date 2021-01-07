import 'package:flutter/material.dart';

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
    return Container();
  }
}
