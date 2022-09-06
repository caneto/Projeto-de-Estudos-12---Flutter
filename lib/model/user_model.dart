import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/datas/users_data.dart';
import 'package:gerenteloja/model/login_model.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  LoginModel? login;

  List<UserData> users = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);


  UserModel(this.login) {
    if(login!.isLoggedIn())
      _loadUsers();
  }

  void _loadUsers()  {

    UserData? userData;

    _firestore.collection("users").snapshots().listen((snapshot){
      for (var change in snapshot.docChanges) {
        String uid = change.doc.id;

        userData!.address = change.doc.get("address");
        userData.email = change.doc.get("email");
        userData.name = change.doc.get("name");

        users.add(userData);
      }
    });

    notifyListeners();

  }

  //void onChangedSearch(String search){
  //  if(!search.trim().isEmpty){
  //    _filter(search.trim());
  //  }
  //}

  //List<Map<String, dynamic>> _filter(String search){
  //  List<Map<String, dynamic>> filteredUsers = List.from(_users.values.toList());
  //  filteredUsers.retainWhere((user){
  //    return user["name"].toUpperCase().contains(search.toUpperCase());
  //  });
  //  return filteredUsers;
  //}

  /*void _subscribeToOrders(String uid){
    _users[uid]!["subscription"] =
        _firestore.collection("users").doc(uid)
          .collection("orders")
          .snapshots().listen((orders) async {

          int numOrders = orders.docs.length;

          double money = 0.0;

          for(DocumentSnapshot d in orders.docs){
            DocumentSnapshot order = await _firestore
                .collection("orders").doc(d.id).get();
            
            if(order.data == null) continue;

            money += order.get("totalPrice"); // .data() !["totalPrice"];
          }
          
          _users[uid]!.addAll(
            {"money": money, "orders": numOrders}
          );
          
          _usersController.add(_users.values.toList());
    });
  }

  Map<String, dynamic>? getUser(String uid){
    return usersuid];
  }

  void _unsubscribeToOrders(String uid){
    _users[uid]?["subscription"].cancel();
  }

  @override
  void dispose() {
    _usersController.close();
  }*/

}