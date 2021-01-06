import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';

class CustomDropdownMenu extends StatefulWidget {
  final String label;
  List<String> items;
  String value;
  String initialValue;
  final Function onChanged;

  CustomDropdownMenu({
    @required this.label,
    @required this.items,
    this.initialValue,
    this.onChanged,
  });

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    this.widget.value = this.widget.initialValue ?? this.widget.items.first;
    final dropdownMenuOptions = this
        .widget
        .items
        .map((String item) => new DropdownMenuItem<String>(
              value: item,
              child: new Text(
                item,
                style: TextStyle(
                  fontFamily: 'Nexa',
                  fontSize: 18,
                ),
              ),
            ))
        .toList();
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(6),
      child: DropdownButtonFormField(
        style: TextStyle(
          fontFamily: 'Nexa',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
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
          labelStyle: kTextStyle.copyWith(
            fontSize: 18,
            color: Colors.green[900],
          ),
        ),
        focusColor: Colors.green,
        value: this.widget.value,
        items: dropdownMenuOptions,
        onChanged: (newValue) {
          setState(() {
            this.widget.value = newValue;
          });

          setState(() {
            this.widget.onChanged(newValue);
          });
        },
      ),
    );
  }
}
