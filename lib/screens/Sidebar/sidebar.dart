import 'dart:math';

import 'package:boticapp_flutter/screens/screens/home.dart';
import 'package:boticapp_flutter/screens/screens/myaccount.dart';
import 'package:flutter/material.dart';
import 'package:boticapp_flutter/widgets/item_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  Sidebar({Key? key}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int tipoUsu = 0;
  String nombre = "";
  int _pos = 0;
  double _value = 0;
  @override
  void initState() {
    super.initState();
    _getTipoUser();
  }
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
                        tipoUsu==2?"https://images.vexels.com/media/users/3/144174/isolated/lists/5652866ea35638b379a776d29dbf2a9f-personaje-de-dibujos-animados-medico.png"
                        :"https://e7.pngegg.com/pngimages/970/388/png-clipart-profession-job-computer-icons-user-profile-avatar-doctor-cartoon-author-head.png"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    nombre,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              )),
              Expanded(
                child: ListView(
                  children: [
                    ItemNavigationWidget(
                      icon: Icons.home,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Home",
                      function: (){
                        setState(() {
                          _pos = 0;
                          _value = 0;
                        });
                      },
                      isVisible: true,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.account_box,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Mi cuenta",
                      function: (){
                        setState(() {
                          _pos = 1;
                          _value = 0;
                        });
                      },
                      isVisible: tipoUsu==1?true:false,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.add_shopping_cart,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Productos",
                      function: (){
                        setState(() {
                          _pos = 2;
                          _value = 0;
                        });
                      },
                      isVisible: true,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.inventory,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Control de Inventario",
                      function: (){
                        setState(() {
                          _pos = 3;
                          _value = 0;
                        });
                      },
                      isVisible: tipoUsu==2?true:false,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.attach_money_sharp,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Control de ventas",
                      function: (){
                        setState(() {
                          _pos = 4;
                          _value = 0;
                        });
                      },
                      isVisible: tipoUsu==2?true:false,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.supervised_user_circle,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Contacto",
                      function: (){
                        setState(() {
                          _pos = 5;
                          _value = 0;
                        });
                      },
                      isVisible: true,
                    ),
                    ItemNavigationWidget(
                      icon: Icons.local_activity_rounded,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Boticas",
                      function: (){
                        setState(() {
                          _pos = 6;
                          _value = 0;
                        });
                      },
                      isVisible: tipoUsu==1?true:false
                    ),
                    ItemNavigationWidget(
                      icon: Icons.logout,
                      colorIcon: Colors.white,
                      colorText: Colors.white,
                      nombre: "Log out",
                      function: () async {
                        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('key');
                        prefs.clear();
                        setState(() {
                          //_pos = 7;
                          _value = 0;
                        });
                      },
                      isVisible: true,
                    )
                    /*__itemNavigationWidget(
                        0, Icons.home, "Home", Colors.white, Colors.white),
                    __itemNavigationWidget(1, Icons.account_box, "Mi Cuenta",
                        Colors.white, Colors.white),
                    __itemNavigationWidget(2, Icons.add_shopping_cart,
                        "Productos", Colors.white, Colors.white),
                    __itemNavigationWidget(3, Icons.inventory,
                        "Control de Inventario", Colors.white, Colors.white),
                    __itemNavigationWidget(4, Icons.attach_money_sharp,
                        "Control de Ventas", Colors.white, Colors.white),
                    __itemNavigationWidget(5, Icons.supervised_user_circle,
                        "Contacto", Colors.white, Colors.white),
                    __itemNavigationWidget(6, Icons.local_activity_rounded,
                        "Boticas", Colors.white, Colors.white),
                    __itemNavigationWidget(
                        7, Icons.logout, "Log out", Colors.white, Colors.white),*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: _value),
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
                        _value = _value == 0 ? 1 : 0;
                      })
                    },
                  )
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_navigateWidget(_pos)],
                  ),
                ),
              ),
            ));
          }),
      GestureDetector(
        onHorizontalDragUpdate: (e) {
            setState(() {
              _value = e.delta.dx > 0 ? 1 : 0;
            });
        }
      ),
    ]));
  }

  _navigateWidget(int _pos) {
    switch (_pos) {
      case 0:
        return Home();
      case 1:
        return MyAccount();
    }
  }

  _getTipoUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      tipoUsu = pref.getInt('tipoUsu')!;
      nombre = pref.getString('nombre')!;
    });
  }
  /*_itemNavigationWidget(int _posItem, IconData icon, String nombre,
      Color colorText, Color colorIcon) {
    return ListTile(
      onTap: () => {
        if(_posItem == 7){
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false)
        }else{
          setState(() {
          _pos = _posItem;
          _value = 0;
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
    );*/
    
  }
