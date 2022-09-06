import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  Map<String, Map<String, dynamic>> _users = {};

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserBloc(){
    _addUsersListener();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _usersController.add(_users.values.toList());
    } else {
      _usersController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search){
    List<Map<String, dynamic>> filteredUsers = List.from(_users.values.toList());
    filteredUsers.retainWhere((user){
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

 }
  
  void _subscribeToOrders(String uid){
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
    return _users[uid];
  }

  void _unsubscribeToOrders(String uid){
    _users[uid]?["subscription"].cancel();
  }

  @override
  void dispose() {
    _usersController.close();
  }

}