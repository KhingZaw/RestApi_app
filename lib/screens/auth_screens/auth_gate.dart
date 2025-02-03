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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // User is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // User is not logged in
          return const LoginOrRegister();
        },
      ),
    );
  }
}
