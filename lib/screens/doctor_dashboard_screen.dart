import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifeline/components/grid_card.dart';
import 'package:lifeline/components/log_out_alert_dialog.dart';
import 'package:lifeline/screens/record_verification_screen.dart';

class DoctorDashboardScreen extends StatefulWidget {
  static String id = 'doctor_dashboard';

  @override
  _DoctorDashboardScreenState createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Doctor\'s Dashboard',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Nexa',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dr. ' + 'Younus', // TODO: Replace Younus with actual name
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Nexa Bold',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/check_record_icon.png',
                    height: 60,
                  ),
                  label: 'Check Record',
                  onTap: () {
                    // TODO: Go to QR Scanner
                  },
                ),
                GridCard(
                  image: Image.asset(
                    'assets/images/lifeline_icons/verify_record_icon.png',
                    height: 60,
                  ),
                  label: 'Verify Record',
                  onTap: () {
                    // TODO: Go to QR Scanner
                    // TESTING
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordVerificationScreen(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
