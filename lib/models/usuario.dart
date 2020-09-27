class Category {
  int id;
  String name;
  String email;
  String senha;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['email'] = email;
    mapping['senha'] = senha;

    return mapping;
  }
}
