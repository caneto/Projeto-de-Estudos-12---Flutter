import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/blocs/user_model.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot order;

  OrderHeader(this.order);

  @override
  Widget build(BuildContext context) {

    //final _userBloc = BlocProvider.getBloc<UserBloc>();
    final _userBloc = UserBloc();

    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List>(
            stream: _userBloc.outUsers,
            builder: (context, snapshot) {

              final _user = _userBloc.getUser(order.get("clientId"));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_user != null ? "${_user["name"]}": ""),
                  Text(_user != null ? "${_user["address"]}": "")
                ],
              );
          }),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Produtos: R\$${order.get("productsPrice").toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w500),),
            Text("Total: R\$${order.get("totalPrice").toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w500),)
          ],
        )
      ],
    );
  }
}
