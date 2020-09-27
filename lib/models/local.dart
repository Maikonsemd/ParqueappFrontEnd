import 'dart:ffi';

class Local {
  int id;
  String regiao;
  String referencialocal;
  String descricaolocal;
  Float latitudelocal;
  Float longitudelocal;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['regiao'] = id;
    mapping['descricaolocal'] = descricaolocal;
    mapping['referencialocal'] = referencialocal;
    mapping['latitudelocal'] = latitudelocal;

    return mapping;
  }
}
