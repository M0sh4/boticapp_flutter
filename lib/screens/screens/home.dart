import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dni = "";
  int tipoUsu = 0;
  
  @override
  void initState(){
    super.initState;
    getDni();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(dni+"_"+tipoUsu.toString())
      );
  }
  void getDni() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dni = prefs.getString('key')!;
      tipoUsu = prefs.getInt('tipoUsu')!;
    });
  }
}