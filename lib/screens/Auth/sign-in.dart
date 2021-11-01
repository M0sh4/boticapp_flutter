import 'package:boticapp_flutter/data/firebase/UsuarioService.dart';
import 'package:boticapp_flutter/data/firebase/auth.dart';
import 'package:boticapp_flutter/domain/entities/UsuarioModel.dart';
import 'package:boticapp_flutter/widgets/RoundedButton.dart';
import 'package:boticapp_flutter/widgets/background_screen.dart';
import 'package:boticapp_flutter/widgets/rounded_input_field.dart';
import 'package:boticapp_flutter/widgets/rounded_input_password.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  UsuarioService userS = new UsuarioService();
  var email =  '';
  var password = '';
  bool isLoading = false;
  bool isEnabled = true;
  UsuarioModel userM =  new UsuarioModel();
  List<UsuarioModel> userList = [];
  var emailUsu = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: BackgroundScreen(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "LOGIN",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Image.asset(
        "lib/utils/fondo-login.png",
        height: size.height * 0.35,
      ),
      RoundedInputField(
        hintText: "Ingresa tu email",
        icon: Icons.person,
        onChanged: (value) {
          email = value;
        },
        inputType: TextInputType.text,
        isEnabled: isEnabled,
      ),
      RoundedInputPassword(
        valueChanged: (value) {
          password = value;
        },
        isEnabled: isEnabled,
      ),
      RoundedButton(
          text: "Ingresar",
          press: () async {
            if(formKey.currentState!.validate()){
              setState(() {
                isLoading= true;
                isEnabled= false;
              });
              await userS.readUser(userM).then((user)=> user.forEach((e) => {
                if(e.emailUsu == email && e.passwordUsu == password){
                    userM.UsuarioModelConst(e.dniUsu, e.nombreUsu, e.apellidosUsu
                    , e.emailUsu, e.telefonoUsu, e.passwordUsu),    
                    setState(() {
                      isLoading= false;
                      isEnabled= true;
                    }),
                    prefs.then((value) => value.setString('key', e.dniUsu)),
                    Navigator.of(context)
                      .pushNamedAndRemoveUntil("/home", (route) => false)
                }
              }));
              setState(() {
                isLoading= false;
                isEnabled= true;
              });
            }
          },
          isLoading: isLoading,
          color: Color.fromRGBO(0, 153, 255, 1),
          textColor: Colors.white),
      RoundedButton(
          text: "Ingresar anonimamente",
          press: () {
            Future anon = _auth.signInAnon();
            anon.then((value) => Navigator.of(context)
                .pushNamedAndRemoveUntil("/home", (route) => false))
                .onError((error, stackTrace) => print(error));
          },
          color: Color.fromRGBO(0, 153, 255, 1),
          textColor: Colors.white,
          isLoading: false
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Aún no tienes una cuenta? ",
              style: TextStyle(color: Color.fromRGBO(0, 153, 255, 1))),
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/signup", (route) => false);
              },
              child: Text(
                "Create una",
                style: TextStyle(
                    color: Color.fromRGBO(0, 153, 255, 1),
                    fontWeight: FontWeight.bold),
              ))
        ],
      )
    ])));
  }
}
