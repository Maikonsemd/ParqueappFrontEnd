import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/Services/category_services.dart';
import 'package:intl/intl.dart';
import 'package:sqlite/Services/todo_services.dart';
import 'package:sqlite/models/todo.dart';

class Ocorrencias extends StatefulWidget {
  @override
  _OcorrenciasState createState() => _OcorrenciasState();
}

class _OcorrenciasState extends State<Ocorrencias> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var todoTitleController = TextEditingController();

  var todoDescriptionController = TextEditingController();

  var todoDateController = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _selectvalue;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

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

  DateTime _datetime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickeDate = await showDatePicker(
        context: context,
        initialDate: _datetime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickeDate != null) {
      setState(() {
        _datetime = _pickeDate;
        todoDateController.text = DateFormat('dd-MM-yyyy').format(_pickeDate);
      });
    }
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
        title: Text('Ocorrências'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // TextField(
            //   controller: todoTitleController,
            //   decoration: InputDecoration(
            //       labelText: 'text',
            //       hintText: 'Write Todo Title',
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10)))),
            // ),
            // TextField(
            //   controller: todoDescriptionController,
            //   decoration: InputDecoration(
            //       labelText: 'Descrição', hintText: 'Digite a descrição aqui'),
            // ),
            // TextField(
            //   controller: todoDateController,
            //   decoration: InputDecoration(
            //       labelText: 'Data',
            //       hintText: 'Digite ou selecione a data ',
            //       prefixIcon: InkWell(
            //         onTap: () {
            //           _selectedTodoDate(context);
            //         },
            //         child: Icon(Icons.calendar_today),
            //       )),
            // ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: _selectvalue,
              items: _categories,
              hint: Text('Categorias'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onChanged: (value) {
                setState(() {
                  _selectvalue = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: _selectvalue,
              items: _categories,
              hint: Text('Local'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onChanged: (value) {
                setState(() {
                  _selectvalue = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: _selectvalue,
              items: _categories,
              hint: Text('Região'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onChanged: (value) {
                setState(() {
                  _selectvalue = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: _selectvalue,
              items: _categories,
              hint: Text('Referência'),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              onChanged: (value) {
                setState(() {
                  _selectvalue = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () async {
                  var todoObject = Todo();

                  todoObject.title = todoTitleController.text;
                  todoObject.description = todoDescriptionController.text;
                  todoObject.isFinished = 0;
                  todoObject.category = _selectvalue.toString();
                  todoObject.todoDate = todoDateController.text;

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);
                  if (result > 0) {
                    _showsucessSnackBar(Text('criado'));
                  }
                  print(result);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)),
                child: Text('REGISTRAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
