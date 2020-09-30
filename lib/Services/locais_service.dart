import 'package:sqlite/models/catgory.dart';
import 'package:sqlite/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  LocalService() {
    _repository = Repository();
  }

  saveLocal(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  readLocal() async {
    return await _repository.readData('categories');
  }

  readLocalByid(categoryId) async {
    return await _repository.readDataByid('categories', categoryId);
  }

  updateLocal(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  delateLocal(categoryId) async {
    return await _repository.delateData('categories', categoryId);
  }
}
