import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/basic_health_record_tab.dart';
import 'package:lifeline/screens/diagnosis_record_tab.dart';

class HealthRecordScreen extends StatefulWidget {
  static String id = 'health_record';

  @override
  _HealthRecordScreenState createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 40.0,
                  child: Image.asset(
                    'assets/images/lifeline_logo.png',
                  ),
                ),
              ),
              Text(
                'Health Record',
                style: kTextStyle.copyWith(fontSize: 24),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
          bottom: TabBar(
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                child: Text(
                  'Basic',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  'Diagnosis',
                  style: kTextStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BasicHealthRecordTab(),
            DiagnosisRecordTab(),
          ],
        ),
      ),
    );
  }
}
