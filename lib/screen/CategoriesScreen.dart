import 'package:flutter/material.dart';
import 'package:sqlite/Services/category_services.dart';
import 'package:sqlite/models/catgory.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>();

  var category;

  var _editcategoryNameController = TextEditingController();
  var _editcategoryDescriptionController = TextEditingController();

  var _selecvalue;
  var _categories = List<DropdownMenuItem>();

  //esta funcao e responsavel por listar as categorias

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
    _loadCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoriesByid(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]['name'] ?? 'No name';
      _editcategoryDescriptionController.text =
          category[0]['description'] ?? 'No description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;

                    var result = await _categoryService.saveCategory(_category);
                    if (result > 0) {
                      print(result);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save')),
            ],
            title: Text('Formulário de categorias'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Digite o nome da categoria',
                        labelText: 'Nome'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Descrição da categoria',
                        labelText: 'Descrição'),
                  ),
                  // DropdownButtonFormField(
                  //   value: _selecvalue,
                  //   items: _categories,
                  //   hint: Text('Category'),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selecvalue = value;
                  //     });
                  //   },
                  // )
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editcategoryNameController.text;
                    _category.description =
                        _editcategoryDescriptionController.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showsucessSnackBar(Text('dado alterado'));
                    }
                  },
                  child: Text('update')),
            ],
            title: Text(' Edit Caterias form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editcategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Write a category', labelText: 'category'),
                  ),
                  TextField(
                    controller: _editcategoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.blue,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result =
                        await _categoryService.delateCategory(categoryId);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showsucessSnackBar(Text('deletado'));
                    }
                  },
                  child: Text('Deletar')),
            ],
            title: Text('Você deseja deletar essa categória'),
          );
        });
  }

  _showsucessSnackBar(message) {
    var _snackbar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                        // print(_categoryList[index].id);
                      }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_categoryList[index].name),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleteFormDialog(context, _categoryList[index].id);
                          })
                    ],
                  ),
                  // subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
