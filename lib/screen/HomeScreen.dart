import 'package:flutter/material.dart';
import 'package:sqlite/Services/category_services.dart';
import 'package:sqlite/Services/todo_services.dart';
import 'package:sqlite/helpers/drawer_navegation.dart';
import 'package:sqlite/models/catgory.dart';
import 'package:sqlite/models/todo.dart';
import 'package:sqlite/screen/OcorrenciasScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();
  // var _categoryService = CategoryService();
  // List<Category> _categoryList = List<Category>();

  getAlltodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAlltodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: DrawerNavegation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(_todoList[index].title ?? 'no title')],
                  ),
                  subtitle: Text(_todoList[index].category ?? 'no category'),
                  trailing: Text(_todoList[index].todoDate ?? 'no date'),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Ocorrencias())),
        child: Icon(Icons.add),
      ),
    );
  }
}
