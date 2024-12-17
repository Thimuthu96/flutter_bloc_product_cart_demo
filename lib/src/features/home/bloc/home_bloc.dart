import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:product_cart_demo/src/features/cart/model/cart_model.dart';

import '../../../data/cart_item_list_data.dart';
import '../../../data/product_data_list.dart';
import '../../common/models/product.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartNavigateEvent>(homeCartNavigateEvent);
    on<HomeWishListNavigateEvent>(homeWishListNavigateEvent);

    on<HomeProductAddToCartEvent>(homeProductAddToCartEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeViewProductEvent>(homeViewProductEvent);
  }

  FutureOr<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(HomeSuccessfullyLoadedState(
          productsList: ProductDataList.productDataList));
    });
  }

  FutureOr<void> homeProductAddToCartEvent(
    HomeProductAddToCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('********');
      debugPrint('Add to Cart Button Clicked');
      addToCart(CartModel(
        id: event.productModel.id,
        name: event.productModel.name,
        quantity: 1,
        price: event.productModel.price,
        imageUrl: event.productModel.imageUrl,
      ));
      debugPrint('********');
      debugPrint(cartItemList.length.toString());
    });
    emit(HomeSuccessfullyLoadedState(
        productsList: ProductDataList.productDataList));
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

  FutureOr<void> homeProductWishListButtonClickedEvent(
    HomeProductWishListButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    debugPrint('********');
    debugPrint('Add to Wishlist Button Clicked');
  }

  FutureOr<void> homeCartNavigateEvent(
    HomeCartNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    debugPrint('********');
    debugPrint('Cart Navigate Clicked');
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeWishListNavigateEvent(
    HomeWishListNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    debugPrint('********');
    debugPrint('Wishlist Navigate Clicked');
    emit(HomeNavigateToWishListActionState());
  }

  FutureOr<void> homeViewProductEvent(
    HomeViewProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeViewProductActionState(
      productModel: event.productModel,
    ));
    // emit(HomeLoadingState());
    // await Future.delayed(const Duration(seconds: 1), () {
    //   emit(HomeViewProductActionState());
    // });
  }
}
