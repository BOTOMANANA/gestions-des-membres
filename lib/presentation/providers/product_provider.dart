// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/domain/usecases/product_usecase/create_product_usecase.dart';
import 'package:association_appli/domain/usecases/product_usecase/delete_product_usecase.dart';
import 'package:association_appli/domain/usecases/product_usecase/get_products_for_activity.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  CreateProductUseCase createProductUseCase;
  DeleteProductUsecase deleteProductUsecase;
  GetProductsForActivity getProductsForActivity;

  ProductProvider({
    required this.createProductUseCase,
    required this.deleteProductUsecase,
    required this.getProductsForActivity,
  });

  ProductState _state = ProductState.initial;
  List<ProductEntity> _products = [];
  String? _errorMessage;
  int? _currentActivityId;

  ProductState get state => _state;
  List<ProductEntity> get products => _products;
  String? get errorMessage => _errorMessage;

  void _handleFailure({required Failure failure}) {
    _errorMessage = failure.errorMessage;
    _setState(newState: ProductState.error);
  }

  void _setState({required ProductState newState}) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchProducts({required int activityId}) async {
    if (_state == ProductState.loading && _currentActivityId == activityId) {
      return;
    }

    _setState(newState: ProductState.loading);
    _currentActivityId = activityId;
    var result = await getProductsForActivity(activityId: activityId);
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (productsList) {
        _products = productsList;
        _setState(newState: ProductState.loaded);
      },
    );
  }

  Future<void> createProduct({required ProductEntity product}) async {
    var result = await createProductUseCase(productEntity: product);
    print("============= create product for provider is call");
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (_) async {
        // Succès: Recharge la liste pour afficher le nouveau produit
        if (_currentActivityId != null) {
          await fetchProducts(activityId: _currentActivityId!);
        } else {
          // Si l'ID n'est pas défini (ne devrait pas arriver), on force la mise à jour
          _setState(newState: ProductState.loaded);
        }
      },
    );
  }

  Future<void> deleteProduct({required int id}) async {
    var result = await deleteProductUsecase(id: id);
    print("==========????? delete product for provider is calling");
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (_) async {
        if (_currentActivityId != null) {
          await fetchProducts(activityId: _currentActivityId!);
        } else {
          _setState(newState: ProductState.loaded);
        }
      },
    );
  }
}
