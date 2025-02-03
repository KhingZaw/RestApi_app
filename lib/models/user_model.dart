import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? phone;
  String? name;
  String? id;
  String? email;
  String? address;
  UserModel({this.phone, this.name, this.id, this.email, this.address});
  //  Convert Firestore snapshot to UserModel
  UserModel.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    id = snap.id;
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    address = data["address"];
  }

  //  Convert UserModel to Firestore data
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }
}
