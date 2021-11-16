class BoticaModel {
  String correo = "";
  String latitud = "";
  String longitud = "";
  String nomBotica = "";
  String password = "";
  String ruc = "";
  String telefono = "";

  BoticaModel.empty();
  BoticaModel(String correo, String latitud, String longitud,String nomBotica,
              String password, String ruc,  String telefono){
      this.correo = correo;
      this.latitud = latitud;
      this.longitud = longitud;
      this.nomBotica = nomBotica;
      this.password = password;
      this.ruc = ruc;
      this.telefono = telefono;
  }
}