import 'package:flutter/material.dart';
import 'package:product_cart_demo/src/features/common/models/product.dart';
import 'package:product_cart_demo/src/features/home/bloc/home_bloc.dart';

import '../../../data/product_data_list.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.index,
    required this.homeBloc,
  });

  final int index;
  final HomeBloc homeBloc;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        widget.homeBloc.add(
          HomeViewProductEvent(
            productModel: ProductModel(
              id: ProductDataList.productDataList[widget.index].id,
              name: ProductDataList.productDataList[widget.index].name,
              description:
                  ProductDataList.productDataList[widget.index].description,
              price: ProductDataList.productDataList[widget.index].price,
              imageUrl: ProductDataList.productDataList[widget.index].imageUrl,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Image.network(
                ProductDataList.productDataList[widget.index].imageUrl,
                width: size.width,
                fit: BoxFit.cover,
                scale: 1,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      ProductDataList.productDataList[widget.index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      ProductDataList.productDataList[widget.index].price
                          .toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  widget.homeBloc.add(HomeProductAddToCartEvent(
                      productModel: ProductModel(
                    id: ProductDataList.productDataList[widget.index].id,
                    name: ProductDataList.productDataList[widget.index].name,
                    description: ProductDataList
                        .productDataList[widget.index].description,
                    price: ProductDataList.productDataList[widget.index].price,
                    imageUrl:
                        ProductDataList.productDataList[widget.index].imageUrl,
                  )));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
