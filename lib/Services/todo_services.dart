import 'package:sqlite/models/todo.dart';
import 'package:sqlite/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }
  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.categoryMap());
  }

  readTodos() async {
    return await _repository.readData('todos');
  }
}
