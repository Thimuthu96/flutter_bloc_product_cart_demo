part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonClickedEvent extends HomeEvent {}

class HomeProductAddToCartEvent extends HomeEvent {
  final ProductModel productModel;
  HomeProductAddToCartEvent({required this.productModel});
}

class HomeCartNavigateEvent extends HomeEvent {}

class HomeWishListNavigateEvent extends HomeEvent {}

class HomeViewProductEvent extends HomeEvent {
  final ProductModel productModel;
  HomeViewProductEvent({required this.productModel});
}
