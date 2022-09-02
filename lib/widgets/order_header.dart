import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {

  //final DocumentSnapshot order;

  //OrderHeader(this.order);

  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.getBloc<UserBloc>();

    //final _user = _userBloc.getUser(order.data["clientId"]);

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Carlos"),
              Text("Rua X. X. Y.")
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Produtos: R\$ 2.00", style: TextStyle(fontWeight: FontWeight.w500),),
            Text("Total: R\$ 5.00", style: TextStyle(fontWeight: FontWeight.w500),)
          ],
        )
      ],
    );
  }
}
