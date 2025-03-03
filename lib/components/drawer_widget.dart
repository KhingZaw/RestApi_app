import 'package:drivers_app/components/drawer_tile_widget.dart';
import 'package:drivers_app/screens/auth_screens/login_or_register.dart';
import 'package:drivers_app/screens/user_screens/home_screen.dart';
import 'package:drivers_app/screens/user_screens/settings_screen.dart';
import 'package:drivers_app/services/aut/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthService authService = AuthService();

  void logOut() async {
    User? currentUser = authService.getCurrentUser();

    if (currentUser != null) {
      try {
        await authService.signOutUser();
        Fluttertoast.showToast(msg: "Successfully logged out.");

        // Navigate to login screen or home screen after logout
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => LoginOrRegister()),
        );
      } catch (e) {
        Fluttertoast.showToast(msg: "Error logging out: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "No user is logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //app Logo
          Image.asset(
            "assets/images/city.jpg",
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          //profile screen
          DrawerTileWidget(
            text: "P R O F I L E",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: Icons.person,
          ),
          //home list title
          DrawerTileWidget(
            text: "H O M E",
            onTap: () => Navigator.pop(context),
            icon: Icons.home,
          ),
          DrawerTileWidget(
            text: "S E T T I N G S",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: Icons.settings,
          ),
          const Spacer(),
          DrawerTileWidget(
            text: "L O G O U T",
            onTap: logOut,
            icon: Icons.logout,
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
