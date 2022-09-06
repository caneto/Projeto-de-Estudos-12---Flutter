import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {

  String? users;
  String? id;

  String? address;
  String? email;
  String? name;

  UserData.fromDocument(DocumentSnapshot? snapshot) {
    id = snapshot?.id;
    address = snapshot?.get('address');
    email = snapshot?.get('email');
    name = snapshot?.get('name');
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "address":address,
      "email":email,
      "name":name
    };
  }

}