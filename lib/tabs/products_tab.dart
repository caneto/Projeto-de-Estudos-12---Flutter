import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenteloja/widgets/category_tile.dart';
//import 'package:gerenteloja/widgets/category_tile.dart';

class ProductsTab extends StatefulWidget { //with AutomaticKeepAliveClientMixin
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab>  {

  @override
  Widget build(BuildContext context) {
    //super.build(context);

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        );
        else {
          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data!.docs.map(
                      (doc) {
                    return CategoryTile(doc);
                  }
              ).toList(),
              color: Colors.grey[500])
              .toList();
        }

       return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index){
            return CategoryTile(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
