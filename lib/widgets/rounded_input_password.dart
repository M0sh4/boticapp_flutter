import 'package:boticapp_flutter/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputPassword extends StatefulWidget {
  final ValueChanged valueChanged;
  final bool isEnabled;
  RoundedInputPassword({
    Key? key, 
    required this.valueChanged,
    required this.isEnabled}) : super(key: key);

  @override
  _RoundedInputPasswordState createState() => _RoundedInputPasswordState();
}

class _RoundedInputPasswordState extends State<RoundedInputPassword>{
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    
    return TextFieldContainer(
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Ingresa tu contraseña",
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                isObscure?Icons.visibility_off:Icons.visibility,
                color: Colors.black
              ),
              onTap: (){
                setState((){
                  isObscure = !isObscure;
                });
              },
              ),
            border: InputBorder.none,
            ),
        validator: (value){
          if(value!.isEmpty){
            return "Ingresa tu contraseña";
          }
        },
        obscureText: isObscure,
        onChanged: widget.valueChanged,
        enabled: widget.isEnabled,
      ),
    );
  }
}