import 'package:boticapp_flutter/domain/entities/BoticaModel.dart';
import 'package:firebase_database/firebase_database.dart';

class BoticaService {
  final db = FirebaseDatabase.instance.reference();
  Future<List<BoticaModel>> readBotica() async {
    List<BoticaModel> boticaList = [];
    try {
      BoticaModel botica;
      await db.child("Botica").get()
      .then((snapshot) => {
          snapshot.value.forEach((index,data){
            botica =  new BoticaModel(data['correo'], data['latitud'].toString(), 
            data['longitud'].toString(), data['nomBotica'], data['password'], data['ruc'].toString(), data['telefono'].toString());
            print(data['correo']+"_"+ data['password']);
            boticaList.add(botica);
          })
      });
      return boticaList;
    } catch(e) {
      print(e.toString());
      return boticaList;
    }
  }
}