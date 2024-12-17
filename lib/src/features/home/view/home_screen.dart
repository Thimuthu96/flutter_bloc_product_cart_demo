import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/product_data_list.dart';
import '../../cart/view/cart_screen.dart';
import '../../product_details/view/product_info.dart';
import '../../wishlist/view/wishlist_screen.dart';
import '../bloc/home_bloc.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        } else if (state is HomeNavigateToWishListActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        } else if (state is HomeViewProductActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductInfo(
                product: state.productModel,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state) {
          case HomeLoadingState():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeEmptyState():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Product Cart Demo"),
              ),
              body: const Center(
                child: Text("No Product"),
              ),
            );
          case HomeSuccessfullyLoadedState():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Product Cart Demo"),
                actions: [
                  IconButton(
                    onPressed: () {
                      _homeBloc.add(HomeWishListNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.favorite_outline_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _homeBloc.add(HomeCartNavigateEvent());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: ProductDataList.productDataList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 3 /
                        3.5, // Adjust aspect ratio for fixed height and width
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      // width: size.width,
                      // height: size.height / 4.5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(162, 230, 230, 230),
                      ),
                      child: ProductItem(
                        index: index,
                        homeBloc: _homeBloc,
                      ),
                    );
                  },
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Something went wrong!"),
              ),
            );
        }
      },
    );
  }
}
