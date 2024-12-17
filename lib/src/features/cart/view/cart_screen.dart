import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart_demo/src/features/cart/bloc/cart_bloc.dart';

import '../widget/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    _cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc _cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<CartBloc, CartState>(
      bloc: _cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {
        if (state is CartItemIncreasingState) {
          //trigger confirmation dialog
        } else if (state is CartItemDecreasingState) {
          //trigger confirmation dialog
        } else if (state is CartItemRemovingState) {
          //trigger confirmation dialog
        } else if (state is CartClearingState) {
          //trigger confirmation dialog
        }
      },
      builder: (context, state) {
        switch (state) {
          case CartLoadingState():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case CartEmptyState():
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
              ),
              body: const Center(
                child: Text('Cart is empty'),
              ),
            );
          case CartSuccessfullyLoadedState():
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 80),
                child: ListView.builder(
                    itemCount: state.cartItemList.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        size: size,
                        cartBloc: _cartBloc,
                        totalAmount: state.totalAmount,
                        cartItemList: state.cartItemList,
                        index: index,
                      );
                    }),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.09,
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '${double.parse(state.totalAmount.toStringAsFixed(2))} LKR',

                          // ' ${state.totalPrice.toString()} LKR',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.white,
                              ),
                        )
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
              ),
              body: const Center(
                child: Text('Something went wrong'),
              ),
            );
        }
      },
    );
  }
}
