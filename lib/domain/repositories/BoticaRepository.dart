import 'package:boticapp_flutter/data/firebase/BoticaService.dart';
import 'package:boticapp_flutter/domain/entities/BoticaModel.dart';

class BoticaRepository {
  BoticaService boticaService = BoticaService();

  Future<List<BoticaModel>> readBotica(){
    return boticaService.readBotica();
  }
}