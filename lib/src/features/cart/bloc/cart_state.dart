part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessfullyLoadedState extends CartState {
  final List<CartModel> cartItemList;
  final double totalAmount;

  CartSuccessfullyLoadedState({
    required this.cartItemList,
    required this.totalAmount,
  });
}

class CartErrorState extends CartState {}

class CartEmptyState extends CartState {}

class CartItemSuccessfullyIncreasedState extends CartState {}

class CartItemSuccessfullyDecreasedState extends CartState {}

class CartItemSuccessfullyRemovedState extends CartState {}

class CartSuccessfullyClearedState extends CartState {}

class CartItemIncreasingState extends CartActionState {}

class CartItemDecreasingState extends CartActionState {}

class CartItemRemovingState extends CartActionState {}

class CartClearingState extends CartActionState {}
