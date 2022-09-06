import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:gerenteloja/validators/login_validators.dart';

class LoginModel extends Model with LoginValidators {

  FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseAdmin;
  Map<String,dynamic> adminData = Map();

  static LoginModel of(BuildContext context) =>
      ScopedModel.of<LoginModel>(context);

  bool isLoading = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentAdmin();
  }

  void signIn({required String email, required String pass,
    required VoidCallback onSuccess, required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async {
      firebaseAdmin = user.user;

      if(user != null){
        if(await verifyPrivileges(firebaseAdmin)){
          onSuccess();
        } else {
          FirebaseAuth.instance.signOut();
          onFail();
        }
      } else {
        onFail();
      }

      isLoading = false;
      notifyListeners();

      await _loadCurrentAdmin();
    }).catchError((onError) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> _loadCurrentAdmin() async {
    if(firebaseAdmin == null) {
      firebaseAdmin = await _auth.currentUser;
    }
    if (firebaseAdmin != null) {
      if (adminData["admin"] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection("admin")
            .doc(firebaseAdmin!.uid)
            .get();

        adminData = docUser.data() as Map<String, dynamic>;
      }
    }
    notifyListeners();
  }

  Future<bool> verifyPrivileges(User? user) async {
    return await FirebaseFirestore.instance.collection("admins").doc(user?.uid).get().then((doc){
      if(doc.data != null){
        return true;
      } else {
        return false;
      }
    }).catchError((e){
      return false;
    });
  }

  bool isLoggedIn() {
    return firebaseAdmin != null;
  }

  Future<void> siginOut() async {
    await _auth.signOut();

    adminData = Map();
    firebaseAdmin = null;
    notifyListeners();
  }


}