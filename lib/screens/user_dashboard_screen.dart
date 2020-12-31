import 'package:flutter/material.dart';
import 'package:lifeline/components/grid_card.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/services/authenticate.dart';

class UserDashboardScreen extends StatefulWidget {
  static String id = 'user_dashboard';

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 50.0,
                child: Image.asset(
                  'assets/images/lifeline_logo.png',
                ),
              ),
            ),
            Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nexa',
                fontSize: 30,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
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
                  // TODO: Replace with actual name
                  'Shihab Sikder',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Nexa',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                GridCard(
                  image: Image.asset(
                    // TODO: Update Icon
                    'assets/images/lifeline_logo.png',
                    height: 60,
                  ),
                  label: 'Health Record',
                  onTap: () {},
                ),
                GridCard(
                  image: Image.asset(
                    // TODO: Update Icon
                    'assets/images/lifeline_logo.png',
                    height: 60,
                  ),
                  label: 'Medical History',
                  onTap: () {},
                ),
                GridCard(
                  image: Image.asset(
                    // TODO: Update Icon
                    'assets/images/lifeline_logo.png',
                    height: 60,
                  ),
                  label: 'Profile',
                  onTap: () {},
                ),
                GridCard(
                  image: Image.asset(
                    // TODO: Update Icon
                    'assets/images/lifeline_logo.png',
                    height: 60,
                  ),
                  label: 'Blood Donor Map',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
