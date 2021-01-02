import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/components/donor_info_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DonorListTab extends StatelessWidget {
  // TODO: Import donor list from firebase and turn it into a list. Use Listbuilder method to create DonorInfoCard List from the donor list and show in the screen.

  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      opacity: 0.9,
      progressIndicator: kWaveLoadingIndicator,
      inAsyncCall: loadingIndicator,
      child: ListView(
        children: [
          DonorInfoCard(
            name: 'Shihab Sikder',
            bloodGroup: 'B+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Adib Abrar',
            bloodGroup: 'B+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Fahim Faisal',
            bloodGroup: 'O-ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
          DonorInfoCard(
            name: 'Farhan Saif',
            bloodGroup: 'A+ve',
            contact: '01793450904',
            location: 'Dhaka',
          ),
        ],
      ),
    );
  }
}
