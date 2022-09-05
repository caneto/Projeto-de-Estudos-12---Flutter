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
          key: Key(order.id),
          initiallyExpanded: order.get("status") != 4,
          title: Text(
            "#${order.id.substring(order.id.length - 7, order.id.length)} - ${states[order.get("status")]}",
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
                    children: order.get("products").map<Widget>((p){
                      return ListTile(
                        title: Text(p["product"]["title"] + " " + p["size"]),
                        subtitle: Text(p["category"] + "/" + p["pid"]),
                        trailing: Text(
                          p["quantity"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection("users").doc(order["clientId"])
                              .collection("orders").doc(order.id).delete();
                          order.reference.delete();
                        },
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
                        onPressed: order.get("status") > 1 ? () {
                          order.reference.update({"status": order.get("status") - 1});
                        }:null,
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
                        onPressed: order.get("status") < 4 ? () {
                          order.reference.update({"status": order.get("status") + 1});
                        }:null,
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
