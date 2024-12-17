import 'package:flutter/material.dart';

import '../../common/models/product.dart';

@immutable
sealed class ProductInfoEvent {}

class ProductInfoInitialEvent extends ProductInfoEvent {
  final ProductModel product;

  ProductInfoInitialEvent({required this.product});
}

class ProoductAddToCartEvent extends ProductInfoEvent {
  final ProductModel product;

  ProoductAddToCartEvent({required this.product});
}
