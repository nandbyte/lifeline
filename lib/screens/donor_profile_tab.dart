import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/components/list_info_card.dart';

class DonorProfileTab extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DonorProfileTab> {
  bool donorStatus = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListInfoCard(
          title: 'Name',
          description: 'Shihab Sikder',
        ),
        ListInfoCard(
          title: 'Contact',
          description: '01794208978',
        ),
        ListInfoCard(
          title: 'Blood Group',
          description: 'B+ve',
        ),
        ListInfoCard(
          title: 'Current Location',
          description: 'Dhaka',
        ),
        ListInfoCard(
          title: 'Last Donation',
          description: 'November 23, 2020',
        ),
        ListInfoCard(
          title: 'Gender',
          description: 'Male',
        ),
        ListInfoCard(
          title: 'Age',
          description: '23',
        ),
        GestureDetector(
          onTap: () {},
          child: Card(
            child: SwitchListTile(
              activeColor: Colors.green,
              title: Text(
                'Donor Status',
                style: kSTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              value: donorStatus,
              onChanged: (bool value) {
                setState(() {
                  donorStatus = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
