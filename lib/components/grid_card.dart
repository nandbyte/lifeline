import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final Image image;
  final String label;
  final Function onTap;

  GridCard({this.image, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this.image,
            SizedBox(
              height: 15,
            ),
            Text(
              this.label,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Nexa Bold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
