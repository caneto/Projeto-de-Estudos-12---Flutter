import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  
  final DocumentSnapshot order;
  
  OrderTile(this.order);

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
            "#${order.id.substring(order.id.length - 7, order.id.length)} - ",
            style: TextStyle(color:order.get("status") != 4 ? Colors.grey[850] : Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(order),
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
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            ),
                          ),
                        child: Text("Excluir"),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[850],
                          minimumSize: Size(88, 36),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          ),
                        ),
                        child: Text("Regredir"),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                          minimumSize: Size(88, 36),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          ),
                        ),
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
