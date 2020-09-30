import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");

    //create table todos
    await database.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)");
    //create table subcategoria
    await database.execute(
        "CREATE TABLE subcategorias(id INTEGER PRIMARY KEY, name TEXT, description TEXT, category TEXT)");
    //create table locais
    await database.execute(
        "CREATE TABLE locais(id INTEGER PRIMARY KEY, name TEXT, description TEXT, regiao TEXT)");
    //create table regiao
    await database.execute(
        "CREATE TABLE regiao(id INTEGER PRIMARY KEY, name TEXT, description TEXT, category TEXT)");
  }
}
