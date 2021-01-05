import 'package:flutter/material.dart';

     Widget _hipaabutton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {},
            child: RichText(
            maxLines: 2,
            overflow:TextOverflow.ellipsis,
              text: TextSpan(children: [
                TextSpan(
                  text: 'You must agree with HIPAA policy to continue.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Click Here',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }