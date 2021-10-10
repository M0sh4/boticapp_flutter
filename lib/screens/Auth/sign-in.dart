import 'package:boticapp_flutter/data/firebase/auth.dart';
import 'package:boticapp_flutter/screens/Sidebar/sidebar.dart';
import 'package:boticapp_flutter/screens/screens/home.dart';
import 'package:boticapp_flutter/widgets/RoundedButton.dart';
import 'package:boticapp_flutter/widgets/rounded_input_field.dart';
import 'package:boticapp_flutter/widgets/rounded_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child:
                  SvgPicture.asset("lib/utils/wavetop.svg", width: size.width),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                "lib/utils/wavebot.svg",
                width: size.width,
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                onChanged: (value) {},
              ),
              RoundedPasswordField(valueChanged: (value) {}),
              RoundedButton(
                  text: "Ingresar",
                  press: () {
                    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
                  },
                  color: Color.fromRGBO(0, 153, 255, 1),
                  textColor: Colors.white
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aún no tienes una cuenta? ",
                      style: TextStyle(color: Color.fromRGBO(0, 153, 255, 1))),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Create una",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 153, 255, 1),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ])
          ],
        ),
      ),
    ));
  }
}
