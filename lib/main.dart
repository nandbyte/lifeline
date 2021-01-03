import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeline/screens/blood_donation_screen.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/screens/registration_screen.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:lifeline/screens/welcome_screen.dart';
import 'package:lifeline/services/authenticate.dart';

Future<void> main() async {
  // Initalize widgets and firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Transparent notification bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Run the app
  runApp(LifeLine());
}

class LifeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        appBarTheme: AppBarTheme(
          elevation: 5.0,
          color: Colors.green[500],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (Auth().getUser() == null)
          ? WelcomeScreen.id
          : UserDashboardScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        UserDashboardScreen.id: (context) => UserDashboardScreen(),
        BloodDonationScreen.id: (context) => BloodDonationScreen(),
      },
    );
  }
}
