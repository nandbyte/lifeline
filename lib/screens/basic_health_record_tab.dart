import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeline/components/custom_dropdown_menu.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/models/basic_health.dart';
import 'package:lifeline/screens/qr_code_screen.dart';
import 'package:lifeline/services/EHR.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BasicHealthRecordTab extends StatefulWidget {
  @override
  _BasicHealthRecordTabState createState() => _BasicHealthRecordTabState();
}

class _BasicHealthRecordTabState extends State<BasicHealthRecordTab> {
  bool loadingIndicator = false;
  final ehrDatabase = new EHR(uid: Auth().getUID());
  final height = new TextEditingController();
  final weight = new TextEditingController();
  String sugarLevel = '';
  String rbcCount = '';
  String wbcCount = '';
  String bloodPressure = '';

  Future<void> loadCurrentRecord() async {
    final uid = Auth().getUID();
    final latestRecord = await EHR(uid: uid).getRecord();
    setState(() {
      height.text = latestRecord.height;
      weight.text = latestRecord.weight;
      sugarLevel = latestRecord.sugerLevel;
      rbcCount = latestRecord.rbc;
      wbcCount = latestRecord.wbc;
      bloodPressure = latestRecord.bp;
    });
  }

  Future<void> _submit() async {
    final _height = height.text;
    final _weight = weight.text;
    final _sugerLevel = sugarLevel;
    final _rbcCount = rbcCount;
    final _bloodPressure = bloodPressure;
    final _wbcCount = wbcCount;
    final _count = await ehrDatabase.getCount();
    basicRecord _record = new basicRecord(
      height: _height,
      weight: _weight,
      sugerLevel: _sugerLevel,
      bp: _bloodPressure,
      rbc: _rbcCount,
      wbc: _wbcCount,
      count: _count,
    );
    print(_record.toMap());
    ehrDatabase.createRecord(_record);
  }

  @override
  void initState() {
    setState(() {
      loadingIndicator = true;
    });
    loadCurrentRecord();
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
                CustomDropdownMenu(
                    label: 'Sugar Level',
                    initialValue: sugarLevel == '' ? null : sugarLevel,
                    onChanged: (value) {
                      setState(() {
                        sugarLevel = value;
                      });
                    },
                    items: [
                      '~70-140 mg/dL',
                      '~141-200 mg/dL',
                      '>200 mg/dL',
                    ]),
                CustomDropdownMenu(
                    label: 'RBC Count',
                    initialValue: rbcCount == '' ? null : rbcCount,
                    onChanged: (value) {
                      setState(() {
                        rbcCount = value;
                      });
                    },
                    items: [
                      'less than 4.7 mcL',
                      '~4.7-6.1 mcL',
                      'higher than 6.1 mcL'
                    ]),
                CustomDropdownMenu(
                    label: 'WBC Count',
                    initialValue: wbcCount == '' ? null : wbcCount,
                    onChanged: (value) {
                      setState(() {
                        wbcCount = value;
                      });
                    },
                    items: [
                      '~9,000-30,000 mcL',
                      '~6,200-17,000 mcL',
                      '~5,000-10,000 mcL'
                    ]),
                CustomDropdownMenu(
                    label: 'Blood Pressure(Sys/Dias)',
                    initialValue: bloodPressure == '' ? null : bloodPressure,
                    onChanged: (value) {
                      setState(() {
                        bloodPressure = value;
                      });
                    },
                    items: [
                      '120/80',
                      '(120-129)/(<80)',
                      '(130-139)/(80-89)',
                      '140/90',
                      '180/120',
                    ]),
                Container(
                  child: RoundedButton(
                    onPressed: () {
                      _submit();
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
                              appBarTitle: 'Share Private Data',
                              qrCodeData: 'LifeLineShare_'+Auth().getUID(),),
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
