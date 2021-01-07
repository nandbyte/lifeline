import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';

class ListInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;

  ListInfoCard({this.title, this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  this.title,
                  style: kTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  this.description,
                  style: kTextStyle.copyWith(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
