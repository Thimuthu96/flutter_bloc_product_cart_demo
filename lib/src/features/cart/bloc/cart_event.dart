part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartIncreaseItemQuantityEvent extends CartEvent {
  final int id;
  final double totalAmount;
  CartIncreaseItemQuantityEvent(this.id, this.totalAmount);
}

class CartDecreaseItemQuantityEvent extends CartEvent {
  final int id;
  final double totalAmount;
  CartDecreaseItemQuantityEvent(this.id, this.totalAmount);
}

class CartRemoveItemEvent extends CartEvent {
  final int id;
  final double totalAmount;
  CartRemoveItemEvent(this.id, this.totalAmount);
}

class CartClearEvent extends CartEvent {}

class CartToCheckoutEvent extends CartEvent {}
