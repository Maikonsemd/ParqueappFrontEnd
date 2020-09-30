import 'package:flutter/material.dart';
import 'package:sqlite/Services/category_services.dart';
import 'package:sqlite/models/catgory.dart';

class SubcategoriaScreen extends StatefulWidget {
  @override
  _SubcategoriaScreenState createState() => _SubcategoriaScreenState();
}

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

class _SubcategoriaScreenState extends State<SubcategoriaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _globalKey,
      appBar: AppBar(
        title: Text('Sub categorias'),
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
                        // _editCategory(context, _categoryList[index].id);
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
                            // _deleteFormDialog(context, _categoryList[index].id);
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
