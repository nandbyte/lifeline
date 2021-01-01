import 'package:flutter/material.dart';
import 'package:lifeline/components/grid_card.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'package:lifeline/services/authenticate.dart';

class UserDashboardScreen extends StatefulWidget {
  static String id = 'user_dashboard';

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  bool loadingIndicator = false;

  AlertDialog getAlert(String title, String msg) {
    return AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        FlatButton(
            onPressed: () {
              Auth().signout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Text("Yes")),
        FlatButton(onPressed: () => Navigator.pop(context), child: Text("No"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              color: Colors.green[800],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => getAlert(
                        "LogOut?", "Are you sure, you want to log out?"));
              })
        ],
        title: Expanded(
          child: Row(
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
                'Dashboard',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Nexa Bold',
                  fontSize: 30,
                ),
              ),
            ],
          ),
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
                  // TODO: Replace with actual name
                  'Shihab Sikder',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Nexa Bold',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
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
