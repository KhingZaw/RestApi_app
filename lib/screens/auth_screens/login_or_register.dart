import 'package:drivers_app/screens/auth_screens/login_screen.dart';
import 'package:drivers_app/screens/auth_screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially, show login screen
  bool showLoginScreen = true;
  //toggle between login and register screens
  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: toggleScreen);
    } else {
      return RegisterScreen(onTap: toggleScreen);
    }
  }
}
