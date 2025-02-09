import 'package:drivers_app/screens/auth_screens/login_or_register.dart';
import 'package:drivers_app/screens/user_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //  print("Auth State Changed: ${snapshot.data}"); // Debug print

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            //print("User Logged In: ${snapshot.data?.email}");
            return const HomeScreen();
          }

          //  print("No User Found - Redirecting to Login");
          return const LoginOrRegister();
        },
      ),
    );
  }
}
