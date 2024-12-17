import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart_demo/src/features/common/models/product.dart';
import 'package:product_cart_demo/src/features/product_details/bloc/product_event.dart';
import 'package:product_cart_demo/src/features/product_details/widgets/product_info_card.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final ProductInfoBloc _productInfoBloc = ProductInfoBloc();

  @override
  void initState() {
    _productInfoBloc.add(ProductInfoInitialEvent(product: widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductInfoBloc, ProductInfoState>(
      bloc: _productInfoBloc,
      listenWhen: (previous, current) => current is ProductInfoActionState,
      buildWhen: (previous, current) => current is! ProductInfoActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case ProductInfoLoadingState():
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ProductInfoLoadedState():
            return ProductInfoCard(
              product: state.product[0],
              productInfoBloc: _productInfoBloc,
            );

          case ProductInfoErrorState():
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Info'),
              ),
              body: const Center(
                child: Text(
                  '404 Not found',
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
