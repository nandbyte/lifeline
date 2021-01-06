import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final obscureText;

  CustomTextField({
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(6),
      child: TextFormField(
        controller: this.widget.controller,
        keyboardType: this.widget.keyboardType,
        obscureText: this.widget.obscureText ?? false,
        style: TextStyle(
          fontFamily: 'Nexa',
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: this.widget.hint,
          labelText: this.widget.label,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
          labelStyle: kTextStyle.copyWith(
            fontSize: 18,
            color: Colors.green[900],
          ),
        ),
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
