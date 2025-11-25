// ignore_for_file: avoid_print

import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDatasources {
  Future<void> insertProduct(ProductModel product);
  Future<void> deleteProduct({required int id});
  Future<List<ProductModel>> getProductsByActivityId(int activityId);
  Future<void> updateProduct(ProductModel product);
}

class ProductLocalDatasourcesImpl implements ProductLocalDatasources {
  final AppDatabaseHelper _helper = AppDatabaseHelper.instance;
  Future<Database?> get _database async => await _helper.getDatabase();

  @override
  Future<void> insertProduct(ProductModel product) async {
    final database = await _database;
    database!.insert(_helper.tableActivityProducts, product.toJson());
    print(
      ' ===>>>Inserting product: ${product.name} for Activity ID: ${product.activityId}',
    );
  }

  @override
  Future<void> deleteProduct({required int id}) async {
    final database = await _database;
    database!.delete(
      _helper.tableActivityProducts,
      where: 'id = ?',
      whereArgs: [id],
    );
    print('=========>>>>>>>>data local Deleting product with ID: $id');
  }

  @override
  Future<List<ProductModel>> getProductsByActivityId(int activityId) async {
    final database = await _database;
    var result = await database!.query(
      _helper.tableActivityProducts,
      where: 'id = ?',
      whereArgs: [activityId],
    );
    print(
      '=========>>> data local Fetching products for Activity ID: $activityId',
    );
    return result.map((products) => ProductModel.fromJson(products)).toList();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {}
}
