import 'package:flutter/material.dart';
import 'package:gerenteloja/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white,),
              border: InputBorder.none
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
             itemBuilder: (context, index){
               return UserTile(snapshot.data[index]);
             },
             separatorBuilder: (context, index){
               return Divider();
             },
             itemCount: 5
          ),
        )
      ],
    );
  }
}
