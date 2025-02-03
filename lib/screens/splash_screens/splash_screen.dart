import 'dart:async';
import 'package:drivers_app/screens/auth_screens/auth_gate.dart';
import 'package:drivers_app/services/aut/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();

  void startTime() {
    Timer(Duration(seconds: 3), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c) => AuthGate()));
      // if (authService.getCurrentUser() != null) {
      //   UserModel? user = await authService.getUser(); // ✅ Await user retrieval

      //   if (user != null) {
      //     // ✅ User exists, go to HomeScreen
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (c) => HomeScreen()));
      //   } else {
      //     // ✅ If user is null, go to login
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (c) => LoginOrRegister()));
      //   }
      // } else {
      //   // ✅ If authService.currentUser is null, go to login
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (c) => LoginOrRegister()));
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Trippo",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
