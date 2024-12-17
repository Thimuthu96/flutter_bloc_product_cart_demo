import 'package:flutter/material.dart';

import '../../common/models/product.dart';

@immutable
sealed class ProductInfoState {}

abstract class ProductInfoActionState extends ProductInfoState {}

class ProductInfoInitial extends ProductInfoState {}

class ProductInfoLoadingState extends ProductInfoState {}

class ProductInfoLoadedState extends ProductInfoState {
  final List<ProductModel> product;

  ProductInfoLoadedState({required this.product});
}

class ProductInfoErrorState extends ProductInfoState {}
