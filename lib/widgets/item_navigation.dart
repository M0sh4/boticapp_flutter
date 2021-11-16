import 'package:flutter/material.dart';

class ItemNavigationWidget extends StatelessWidget {
  final IconData icon;
  final String nombre;
  final Color colorText;
  final Color colorIcon;
  final VoidCallback function;
  final bool isVisible;

  const ItemNavigationWidget(
      {Key? key,
      required this.icon,
      required this.nombre,
      required this.colorText,
      required this.colorIcon,
      required this.function, 
      required this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Visibility(
        child: ListTile(
          onTap: () => function.call(),
          leading: Icon(
            icon,
            color: colorIcon,
          ),
          title: Text(
            nombre,
            style: TextStyle(color: colorText),
          ),
        ),
        visible: isVisible,
      ),
    );
  }
}
