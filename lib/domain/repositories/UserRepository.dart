import 'package:boticapp_flutter/data/firebase/UserService.dart';
import 'package:boticapp_flutter/domain/entities/UserModel.dart';

class UserRepository {
  UserService usuarioService = UserService();
  
  Future createUserRepo(UserModel usuarioModel) async {
    return usuarioService.createUser(usuarioModel);
  }

  Future<List<UserModel>> readUserRepo(UserModel usuario) async {
    return usuarioService.readUser(usuario);
  }
}