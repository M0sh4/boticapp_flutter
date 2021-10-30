import 'package:flutter/material.dart';

class ItemNavigationWidget extends StatelessWidget {
    final IconData icon;
    final String nombre;
    final Color colorText;
    final Color colorIcon;
    final VoidCallback function;

    const ItemNavigationWidget({Key? key, 
    required this.icon, 
    required this.nombre,
    required this.colorText, 
    required this.colorIcon, 
    required this.function
    }) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return ListTile(
      onTap: () => function.call(),
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