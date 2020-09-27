class SubCategory {
  int id;
  String name;
  String description;
  String category;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    mapping['category'] = category;

    return mapping;
  }
}
