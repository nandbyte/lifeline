import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';

class DonorMapTab extends StatelessWidget {
  const DonorMapTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO: Implement map functionalities
      child: Text(
        'Donor Map',
        style: kTextStyle.copyWith(fontSize: 20),
      ),
    );
  }
}
