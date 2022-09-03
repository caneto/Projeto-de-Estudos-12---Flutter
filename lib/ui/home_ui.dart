import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gerenteloja/tabs/orders_tab.dart';
import 'package:gerenteloja/tabs/users_tab.dart';
import 'package:gerenteloja/blocs/user_bloc.dart';
import 'package:gerenteloja/blocs/orders_bloc.dart';

//import 'package:gerenteloja/tabs/orders_tab.dart';
//import 'package:gerenteloja/tabs/products_tab.dart';
//import 'package:gerenteloja/tabs/users_tab.dart';
//import 'package:gerenteloja/widgets/edit_category_dialog.dart';

class HomeUi extends StatefulWidget {
  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {

  PageController? _pageController;
  int _page = 0;

  late UserBloc _userBloc;
  late OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: _buildBottomNavigationbar(),
      body: SafeArea(
        child: BlocProvider(
          blocs: [Bloc((i) => _userBloc)],
          dependencies: [],
          child: BlocProvider(
            blocs: [Bloc((i) => _ordersBloc)],
            dependencies: [],
            child: PageView(
              controller: _pageController,
              onPageChanged: (p) {
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                UsersTab(),
                OrdersTab(),
                //Container(color: Colors.yellow,),
                Container(color: Colors.green,),
              ],
            ),
          ),
        ),
      ), /*

                ProductsTab()
              ],
            ),
          ),
        ),*/
      floatingActionButton: _buildFloating(),
    );
  }

  _buildBottomNavigationbar() {
    return BottomNavigationBar(
      currentIndex: _page,
      onTap: (p) {
        _pageController?.animateToPage(p,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutQuad);
      },
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Clientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Produtos',
        ),
      ],
      selectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      selectedItemColor: Colors.yellowAccent,
      unselectedItemColor: Colors.white,
    );
  }

  Widget _buildFloating() {
    switch (_page) {
      case 0:
        return Container();
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
                child: Icon(Icons.arrow_downward, color: Colors.pinkAccent,),
                backgroundColor: Colors.white,
                label: "Concluídos Abaixo",
                labelStyle: TextStyle(fontSize: 14),
                onTap: () {
                  //_ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward, color: Colors.pinkAccent,),
                backgroundColor: Colors.white,
                label: "Concluídos Acima",
                labelStyle: TextStyle(fontSize: 14),
                onTap: () {
                  //_ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
                }
            )
          ],
        );
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            /*  showDialog(context: context,
                builder: (context) => EditCategoryDialog()
            );*/
          },
        );
    }
    return Container();
  }
}
