import 'package:sqlite/models/catgory.dart';
import 'package:sqlite/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  readCategories() async {
    return await _repository.readData('categories');
  }

  readCategoriesByid(categoryId) async {
    return await _repository.readDataByid('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  delateCategory(categoryId) async {
    return await _repository.delateData('categories', categoryId);
  }
}
