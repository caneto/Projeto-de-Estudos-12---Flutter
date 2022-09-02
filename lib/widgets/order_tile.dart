import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:gerenteloja/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  
  //final DocumentSnapshot order;
  
  //OrderTile(this.order);

  final states = [
    "", "Em preparação", "Em transporte", "Aguardando Entrega", "Entregue"
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#xxxxx Entregue",
            style: TextStyle(color:/* order.data["status"] != 4 ? Colors.grey[850] :*/ Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //OrderHeader(order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[ListTile(
                      title: Text("Camiseta XXX"),
                      subtitle: Text("Camisetas"),
                      trailing: Text(
                        "2",
                        style: TextStyle(fontSize: 20),
                      ),
                      contentPadding: EdgeInsets.zero,
                     )
                   ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.red,
                        child: Text("Excluir"),
                      ),
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.grey[850],
                        child: Text("Regredir"),
                      ),
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.green,
                        child: Text("Avançar"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
