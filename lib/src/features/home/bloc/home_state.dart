part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessfullyLoadedState extends HomeState {
  final List<ProductModel> productsList;
  HomeSuccessfullyLoadedState({required this.productsList});
}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishListActionState extends HomeActionState {}

class HomeNavigateToCartActionState extends HomeActionState {}

class HomeViewProductActionState extends HomeActionState {
  final ProductModel productModel;
  HomeViewProductActionState({required this.productModel});
}
