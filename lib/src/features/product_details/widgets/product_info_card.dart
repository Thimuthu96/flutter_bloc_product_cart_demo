import 'package:flutter/material.dart';
import 'package:product_cart_demo/src/features/product_details/bloc/product_event.dart';

import '../../common/models/product.dart';
import '../bloc/product_bloc.dart';

class ProductInfoCard extends StatefulWidget {
  const ProductInfoCard({
    super.key,
    required this.product,
    required this.productInfoBloc,
  });

  final ProductModel product;
  final ProductInfoBloc productInfoBloc;

  @override
  State<ProductInfoCard> createState() => _ProductInfoCardState();
}

class _ProductInfoCardState extends State<ProductInfoCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        title: Text(widget.product.name),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Image.network(
                widget.product.imageUrl,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Text(
                  '${widget.product.price} LKR',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: size.width,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              widget.productInfoBloc.add(
                ProoductAddToCartEvent(
                  product: ProductModel(
                    id: widget.product.id,
                    name: widget.product.name,
                    description: widget.product.description,
                    price: widget.product.price,
                    imageUrl: widget.product.imageUrl,
                  ),
                ),
              );
            },
            label: Text(
              'Add To Cart',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
