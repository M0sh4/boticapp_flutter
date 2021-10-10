import 'dart:math';

import 'package:boticapp_flutter/screens/screens/home.dart';
import 'package:boticapp_flutter/screens/screens/myaccount.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  Sidebar({Key? key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int pos = 0;
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.blue, Colors.blue, Colors.black],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
      ),
      SafeArea(
        child: Container(
          width: 200.0,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Eren Jager",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              )),
              Expanded(
                child: ListView(
                  children: [
                    _itemNavigationWidget(
                        0, Icons.home, "Home", Colors.white, Colors.white),
                    _itemNavigationWidget(1, Icons.account_box, "Mi Cuenta",
                        Colors.white, Colors.white),
                    _itemNavigationWidget(2, Icons.add_shopping_cart,
                        "Productos", Colors.white, Colors.white),
                    _itemNavigationWidget(3, Icons.inventory,
                        "Control de Inventario", Colors.white, Colors.white),
                    _itemNavigationWidget(4, Icons.attach_money_sharp,
                        "Control de Ventas", Colors.white, Colors.white),
                    _itemNavigationWidget(5, Icons.supervised_user_circle,
                        "Contacto", Colors.white, Colors.white),
                    _itemNavigationWidget(6, Icons.local_activity_rounded,
                        "Boticas", Colors.white, Colors.white),
                    _itemNavigationWidget(
                        7, Icons.logout, "Log out", Colors.white, Colors.white),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          builder: (_, double val, __) {
            return (Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(0, 3, 200 * val)
                ..rotateY((pi / 6) * val),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("BoticApp"),
                  leading: IconButton(
                    icon: Icon(Icons.view_sidebar),
                    onPressed: ()=>{
                      setState((){
                        value = value == 0 ? 1 : 0;
                      })
                    },
                  )
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_navigateWidget(pos)],
                  ),
                ),
              ),
            ));
          }),
      GestureDetector(
        onHorizontalDragUpdate: (e) {
            setState(() {
              value = e.delta.dx > 0 ? 1 : 0;
            });
        }
      ),
    ]));
  }

  _navigateWidget(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return MyAccount();
    }
  }

  _itemNavigationWidget(int posItem, IconData icon, String nombre,
      Color colorText, Color colorIcon) {
    return ListTile(
      onTap: () => {
        if(posItem == 7){
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false)
        }else{
          setState(() {
          pos = posItem;
          value = 0;
         })
        }
      },
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      title: Text(
        nombre,
        style: TextStyle(color: colorText),
      ),
    );
  }
}
