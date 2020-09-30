import 'package:sqlite/models/catgory.dart';
import 'package:sqlite/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  SubCategoriaService() {
    _repository = Repository();
  }

  saveSubCategoria(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  readSubCategoria() async {
    return await _repository.readData('categories');
  }

  readSubCategoriaByid(categoryId) async {
    return await _repository.readDataByid('categories', categoryId);
  }

  updateSubCategoria(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  delateSubCategoria(categoryId) async {
    return await _repository.delateData('categories', categoryId);
  }
}
