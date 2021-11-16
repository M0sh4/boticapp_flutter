import 'package:boticapp_flutter/data/firebase/auth.dart';
import 'package:boticapp_flutter/domain/entities/BoticaModel.dart';
import 'package:boticapp_flutter/domain/entities/UserModel.dart';
import 'package:boticapp_flutter/domain/repositories/BoticaRepository.dart';
import 'package:boticapp_flutter/domain/repositories/UserRepository.dart';
import 'package:boticapp_flutter/widgets/RoundedButton.dart';
import 'package:boticapp_flutter/widgets/background_screen.dart';
import 'package:boticapp_flutter/widgets/rounded_input_field.dart';
import 'package:boticapp_flutter/widgets/rounded_input_password.dart';
import 'package:boticapp_flutter/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  UserRepository userRepository= new UserRepository();
  BoticaRepository boticaRepository= new BoticaRepository();
  var email =  '';
  var password = '';
  int tipoUsu = 0;
  bool isLoading = false;
  bool isEnabled = true;
  UserModel userM = UserModel.empty();
  BoticaModel boticaM = BoticaModel.empty();
  List<UserModel> userList = [];
  late FToast fToast = FToast();
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _getPref();
  }
  Widget toast = ToastWidget(
    msg: "Usuario y/o Contraseña incorrecta", 
    color: Colors.redAccent,
    icon: Icon(Icons.dangerous_rounded),
  );
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
              await userRepository.readUserRepo(userM).then((user)=> user.forEach((e) => {
                if(e.emailUsu == email && e.passwordUsu == password){
                    userM =  new UserModel(e.dniUsu, e.nombreUsu, e.apellidosUsu
                    , e.emailUsu, e.telefonoUsu, e.passwordUsu),    
                    setState(() {
                      isLoading= false;
                      isEnabled= true;
                    }),
                    prefs.then((value) => {
                      value.setString('key', e.dniUsu),
                      value.setInt('tipoUsu', 1),
                      value.setString('nombre', userM.nombreUsu  +" " + userM.apellidosUsu )
                    }),
                    Navigator.of(context)
                      .pushNamedAndRemoveUntil("/home", (route) => false)
                }
              }));
              if(userM.dniUsu == ''){
                await boticaRepository.readBotica().then((botica) => botica.forEach((e) =>{ 
                  if(e.correo == email && e.password == password){
                    boticaM = new BoticaModel(e.correo, e.latitud, e.longitud, e.nomBotica, e.password, e.ruc, e.telefono),
                    setState((){
                      isLoading = false;
                      isEnabled = true;
                    }),
                    prefs.then((value) => {
                      value.setString('key', boticaM.ruc), 
                      value.setInt('tipoUsu', 2),
                      value.setString('nombre', boticaM.nomBotica)
                    }),
                    Navigator.of(context)
                      .pushNamedAndRemoveUntil("/home", (route) => false)
                  },
                  print(e.correo + "_" + e.password)
                }));
              }
              setState(() {
                isLoading= false;
                isEnabled= true;
              });
              if(userM.dniUsu == '' && boticaM.ruc == ''){
                fToast.showToast(
                child: toast,
                gravity: ToastGravity.BOTTOM,
                toastDuration: Duration(seconds: 2),
                fadeDuration: 350
                );
              }
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
                    .pushNamedAndRemoveUntil("/signup", (route) => true);
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

  _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tipoUsu = pref.getInt('tipoUsu')!;
    if(tipoUsu != 0){
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }
}
