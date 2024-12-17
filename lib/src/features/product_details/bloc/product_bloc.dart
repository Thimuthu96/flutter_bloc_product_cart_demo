import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:product_cart_demo/src/data/selected_product.dart';

import '../../../data/cart_item_list_data.dart';
import '../../cart/model/cart_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductInfoBloc extends Bloc<ProductInfoEvent, ProductInfoState> {
  ProductInfoBloc() : super(ProductInfoInitial()) {
    on<ProductInfoInitialEvent>(productInfoInitialEvent);
    on<ProoductAddToCartEvent>(prooductAddToCartEvent);
  }

  FutureOr<void> productInfoInitialEvent(
    ProductInfoInitialEvent event,
    Emitter<ProductInfoState> emit,
  ) async {
    emit(ProductInfoLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      selectedProduct.clear();
      selectedProduct.add(event.product);
      selectedProduct.isNotEmpty
          ? emit(ProductInfoLoadedState(product: selectedProduct))
          : emit(ProductInfoErrorState());
    });
  }

  FutureOr<void> prooductAddToCartEvent(
    ProoductAddToCartEvent event,
    Emitter<ProductInfoState> emit,
  ) async {
    emit(ProductInfoLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('********');
      debugPrint('Product Add to Cart Button Clicked');
      addToCart(CartModel(
        id: event.product.id,
        name: event.product.name,
        quantity: 1,
        price: event.product.price,
        imageUrl: event.product.imageUrl,
      ));
    });
    emit(ProductInfoLoadedState(product: selectedProduct));
  }

  //check cart item is already present or not
  void addToCart(CartModel item) async {
    final existingCartItemIndex = cartItemList.indexWhere(
      (cartItem) => cartItem.id == item.id,
    );

    if (existingCartItemIndex >= 0) {
      cartItemList[existingCartItemIndex] = CartModel(
        id: cartItemList[existingCartItemIndex].id,
        name: cartItemList[existingCartItemIndex].name,
        quantity: cartItemList[existingCartItemIndex].quantity + item.quantity,
        price: cartItemList[existingCartItemIndex].price,
        imageUrl: cartItemList[existingCartItemIndex].imageUrl,
      );
    } else {
      cartItemList.add(item);
    }
  }
}
