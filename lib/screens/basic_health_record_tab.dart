import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/qr_code_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BasicHealthRecordTab extends StatefulWidget {
  @override
  _BasicHealthRecordTabState createState() => _BasicHealthRecordTabState();
}

class _BasicHealthRecordTabState extends State<BasicHealthRecordTab> {
  bool loadingIndicator = false;

  final height = new TextEditingController();
  final weight = new TextEditingController();
  String sugarLevel = '';
  // TODO: Define all TextEditingControllers here

  // TODO: Define functions and variables to fetch curretn user's basic health records
  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    // TODO: Call the function that fetches the user health record data
    setState(() {
      loadingIndicator = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ModalProgressHUD(
          color: Colors.white,
          opacity: 0.9,
          progressIndicator: kWaveLoadingIndicator,
          inAsyncCall: loadingIndicator,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTextField(
                  label: "Height",
                  hint: "In Centimeters",
                  controller: height,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Weight",
                  hint: "In Kilograms",
                  controller: weight,
                  keyboardType: TextInputType.number,
                ),
                CustomDropdownMenu(label: 'Sugar Level', items: [
                  '~70-140 mg/dL',
                  '~141-200 mg/dL',
                  '>200 mg/dL',
                ]),
                CustomDropdownMenu(label: 'RBC Count', items: [
                  'less than 4.7 mcL',
                  '~4.7-6.1 mcL',
                  'higher than 6.1 mcL'
                ]),
                CustomDropdownMenu(label: 'WBC Count', items: [
                  '~9,000-30,000 mcL',
                  '~6,200-17,000 mcL',
                  '~5,000-10,000 mcL'
                ]),
                CustomDropdownMenu(label: 'Blood Pressure(Sys/Dias)', items: [
                  '120/80',
                  '(120-129)/(<80)',
                  '(130-139)/(80-89)',
                  '140/90',
                  '180/120',
                ]),
                Container(
                  child: RoundedButton(
                    onPressed: () {
                      // TODO: Update basic health record for the user
                    },
                    text: 'Update',
                    color: Colors.green[700],
                  ),
                ),
                Container(
                  child: RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrCodeScreen(
                              // TODO: Replace qrCodeData with real data (UID only => this will provide health record)
                              appBarTitle: 'Share Private Data',
                              qrCodeData: 'qrCodeData'),
                        ),
                      );
                    },
                    text: 'Share',
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
