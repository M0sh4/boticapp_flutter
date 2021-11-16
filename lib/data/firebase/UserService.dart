import 'package:boticapp_flutter/domain/entities/UserModel.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  final db = FirebaseDatabase.instance.reference();
  Future createUser(UserModel usuario) async {
    try {
      String key = db.child("Usuarios").push().key;
      return db.child("Usuarios").child(key).set({
        'id': key,
        'dniUsu': usuario.dniUsu,
        'nombreUsu': usuario.nombreUsu,
        'apellidosUsu': usuario.apellidosUsu,
        'emailUsu': usuario.emailUsu,
        'telefonoUsu': usuario.telefonoUsu,
        'passwordUsu': usuario.passwordUsu
      }).then((dynamic dy) => print(dy)).onError((error, stackTrace) => print(error));
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  
  Future<List<UserModel>> readUser(UserModel usuario) async {
    List<UserModel> userList = [];
    try {
      UserModel user;
      await db.child("Usuarios").get()
      .then((snapshot) => {
          snapshot.value.forEach((index,data){
            user =  new UserModel(data['dniUsu'], data['nombreUsu'], 
            data['apellidosUsu'], data['emailUsu'], data['telefonoUsu'], data['passwordUsu']);
            userList.add(user);
          })
      });
      return userList;
    } catch(e) {
      print(e.toString());
      return userList;
    }
  }
}