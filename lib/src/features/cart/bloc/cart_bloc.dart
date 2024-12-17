import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/cart_item_list_data.dart';
import '../model/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartIncreaseItemQuantityEvent>(cartIncreaseItemQuantityEvent);
    on<CartDecreaseItemQuantityEvent>(cartDecreaseItemQuantityEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
    on<CartClearEvent>(cartClearEvent);
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {
      final double total = cartItemList.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price * element.quantity,
      );
      cartItemList.isNotEmpty
          ? emit(CartSuccessfullyLoadedState(
              cartItemList: cartItemList,
              totalAmount: total,
            ))
          : emit(CartEmptyState());
    });

    debugPrint('********');
    debugPrint('Cart item count : ${cartItemList.length.toString()}');
  }

  FutureOr<void> cartIncreaseItemQuantityEvent(
    CartIncreaseItemQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadingState());
    debugPrint('********');
    debugPrint("Cart item increased");

    handleQuantity(event.id, true, emit, event.totalAmount);
  }

  FutureOr<void> cartDecreaseItemQuantityEvent(
    CartDecreaseItemQuantityEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadingState());
    debugPrint('********');
    debugPrint("Cart item decreased");
    handleQuantity(event.id, false, emit, event.totalAmount);
  }

  FutureOr<void> cartRemoveItemEvent(
    CartRemoveItemEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadingState());
    emit(CartItemRemovingState());
    debugPrint('********');
    debugPrint('Remove Item ${event.id.toString()}');
    final selectedItemIndex =
        cartItemList.indexWhere((element) => element.id == event.id);
    final removedItem = cartItemList[selectedItemIndex];
    final updatedTotalAmount =
        event.totalAmount - (removedItem.price * removedItem.quantity);

    cartItemList.removeAt(selectedItemIndex);
    emit(CartSuccessfullyLoadedState(
      cartItemList: List.from(cartItemList),
      totalAmount: updatedTotalAmount,
    ));
  }

  FutureOr<void> cartClearEvent(
    CartClearEvent event,
    Emitter<CartState> emit,
  ) {}

  //handle item quantity increase or decrease
  void handleQuantity(
    int id,
    bool isIncrease,
    Emitter<CartState> emit,
    double totalAmount,
  ) async {
    final selectedItemIndex =
        cartItemList.indexWhere((cartItem) => cartItem.id == id);

    if (isIncrease) {
      cartItemList[selectedItemIndex] = CartModel(
        id: cartItemList[selectedItemIndex].id,
        name: cartItemList[selectedItemIndex].name,
        quantity: cartItemList[selectedItemIndex].quantity + 1,
        price: cartItemList[selectedItemIndex].price,
        imageUrl: cartItemList[selectedItemIndex].imageUrl,
      );
      emit(CartSuccessfullyLoadedState(
        cartItemList: cartItemList,
        totalAmount: totalAmount + cartItemList[selectedItemIndex].price,
      ));
    } else {
      cartItemList[selectedItemIndex] = CartModel(
        id: cartItemList[selectedItemIndex].id,
        name: cartItemList[selectedItemIndex].name,
        quantity: cartItemList[selectedItemIndex].quantity - 1,
        price: cartItemList[selectedItemIndex].price,
        imageUrl: cartItemList[selectedItemIndex].imageUrl,
      );
      emit(CartSuccessfullyLoadedState(
        cartItemList: cartItemList,
        totalAmount: totalAmount - cartItemList[selectedItemIndex].price,
      ));
    }
  }
}
