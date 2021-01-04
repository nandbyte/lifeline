import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Nexa Bold',
  fontSize: 30,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

var kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  hintStyle: TextStyle(
    fontFamily: 'Nexa',
  ),
  labelStyle: TextStyle(
    fontFamily: 'Nexa',
  ),
);

var kWaveLoadingIndicator = SpinKitWave(
  color: Colors.green,
);

Container createTextFieldText(
    {BuildContext context,
    String label,
    String hint,
    TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: kTextFieldDecoration,
    ),
  );
}

Container createTextFieldNumber(
    {BuildContext context,
    String label,
    String hint,
    TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: kTextFieldDecoration,
    ),
  );
}

Container createTextFieldPhone(
    {BuildContext context,
    String label,
    String hint,
    TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: kTextFieldDecoration,
    ),
  );
}

Container createTextFieldDate(
    {BuildContext context,
    String label,
    String hint,
    TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.datetime,
      decoration: kTextFieldDecoration,
    ),
  );
}

Container createTextFieldLocation(
    {BuildContext context,
    String label,
    String hint,
    TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.streetAddress,
      decoration: kTextFieldDecoration,
    ),
  );
}
