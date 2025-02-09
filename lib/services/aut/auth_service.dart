import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  UserModel? currentUserModel;
  //register user firebase auth and firebase database
  Future<UserCredential?> registerUser(String email, String password,
      String name, String phone, String address) async {
    try {
      UserCredential auth = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? currentUser = auth.user;

      if (currentUser != null) {
        // Create user data map
        Map<String, dynamic> userMap = {
          "id": currentUser.uid,
          "name": name,
          "email": email,
          "phone": phone,
          "address": address,
          "createdAt": FieldValue.serverTimestamp(), // Store timestamp
        };

        // Save to Firestore instead of Realtime Database
        await firestore.collection("users").doc(currentUser.uid).set(userMap);

        await Fluttertoast.showToast(msg: "Successfully Registered");
      }

      return auth;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Error occurred: ${e.message}");
      return null;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      Fluttertoast.showToast(msg: "Logout error: $e");
    }
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "An unknown error occurred: ${e.toString()}");
      return false;
    }
  }
}
