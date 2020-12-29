import 'package:flutter/material.dart';
import 'package:lifeline/screens/login_screen.dart';
import 'package:lifeline/screens/registration_screen.dart';
import 'package:lifeline/screens/welcome_screen.dart';

void main() {
  runApp(LifeLine());
}

class LifeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
