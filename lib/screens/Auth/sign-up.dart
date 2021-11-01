import 'package:boticapp_flutter/data/firebase/UsuarioService.dart';
import 'package:boticapp_flutter/domain/entities/UsuarioModel.dart';
import 'package:boticapp_flutter/widgets/RoundedButton.dart';
import 'package:boticapp_flutter/widgets/background_screen.dart';
import 'package:boticapp_flutter/widgets/rounded_input_field.dart';
import 'package:boticapp_flutter/widgets/rounded_input_password.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UsuarioService db = new UsuarioService();
  UsuarioModel usu = new UsuarioModel();
  bool isLoading =  false;
  bool isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BackgroundScreen(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Creación de Cuenta",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Container(margin: EdgeInsets.symmetric(vertical: 5)),
      RoundedInputField(
        hintText: "Ingresa tu Dni",
        icon: Icons.perm_identity,
        onChanged: (value) {
          usu.dniUsu = value;
        },
        maxLength: 8,
        inputType: TextInputType.number,
        isEnabled: isEnabled,
      ),
      RoundedInputField(
        hintText: "Ingresa tu Nombre",
        icon: Icons.person_pin,
        onChanged: (value) {
          usu.nombreUsu = value;
        },
        inputType: TextInputType.text,
        isEnabled: isEnabled,
      ),
      RoundedInputField(
        hintText: "Ingresa tus Apellidos",
        icon: Icons.family_restroom,
        onChanged: (value) {
          usu.apellidosUsu = value;
        },
        inputType: TextInputType.text,
        isEnabled: isEnabled,
      ),
      RoundedInputField(
        hintText: "Ingresa tu email",
        icon: Icons.email,
        onChanged: (value) {
          usu.emailUsu = value;
        },
        inputType: TextInputType.emailAddress,
        isEnabled: isEnabled,
      ),
      RoundedInputField(
        hintText: "Ingresa tu Telefono",
        icon: Icons.phone_android,
        onChanged: (value) {
          usu.telefonoUsu = value;
        },
        inputType: TextInputType.number,
        maxLength: 9,
        isEnabled: isEnabled,
      ),
      RoundedInputPassword(valueChanged: (value) {
          usu.passwordUsu = value;
      },
      isEnabled: isEnabled,
      ),
      RoundedButton(
          text: "Crear",
          press: () async {
            if(formKey.currentState!.validate()){
              setState(() {
                isLoading= true;
                isEnabled= false;
              });
              await db.createUser(usu).then((value) =>{
                setState(() {
                    isLoading= false;
                    isEnabled= false;
                }),
                Navigator.of(context)
                 .pushNamedAndRemoveUntil("/", (route) => false),
              });
            }
          },
          isLoading: isLoading,
          color: Color.fromRGBO(0, 153, 255, 1),
          textColor: Colors.white)
    ]))
    );
  }
}
