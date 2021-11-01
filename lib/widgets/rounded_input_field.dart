import 'package:boticapp_flutter/widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final bool isEnabled;
  final IconData icon;
  final ValueChanged onChanged;
  final int? maxLength;
  final TextInputType inputType;
  const RoundedInputField({
    Key? key, 
    required this.hintText, 
    required this.icon, 
    required this.onChanged, 
    this.maxLength, 
    required this.inputType,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.black),
          hintText: hintText,
          border: InputBorder.none,
          counterText: ""
        ),
        maxLength: maxLength,
        keyboardType: inputType,
        validator: (value){
          if(value == null || value.isEmpty){
            return hintText;
          }
        },
        enabled: isEnabled,
      ),
    );
  }
}