import 'package:flutter/material.dart';

import '../bloc/cart_bloc.dart';
import '../model/cart_model.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.size,
    required CartBloc cartBloc,
    required this.totalAmount,
    required this.cartItemList,
    required this.index,
  }) : _cartBloc = cartBloc;

  final Size size;
  final CartBloc _cartBloc;
  final double totalAmount;
  final List<CartModel> cartItemList;
  final int index;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          // vertical: 10,
        ),
        child: Column(
          children: [
            Container(
              width: widget.size.width,
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromARGB(162, 230, 230, 230),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    //image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Image.network(
                        widget.cartItemList[widget.index].imageUrl,
                        width: widget.size.width,
                        fit: BoxFit.contain,
                        scale: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    //name with prices
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItemList[widget.index].name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              '${widget.cartItemList[widget.index].price.toString()} LKR',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        )),
                    const Spacer(),
                    //quantity

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //increase
                        GestureDetector(
                          onTap: () {
                            widget._cartBloc.add(CartIncreaseItemQuantityEvent(
                              widget.cartItemList[widget.index].id,
                              widget.totalAmount,
                            ));
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.cartItemList[widget.index].quantity.toString(),
                        ),
                        const SizedBox(height: 7),
                        //decrease
                        GestureDetector(
                          onTap: () {
                            widget.cartItemList[widget.index].quantity > 1
                                ? widget._cartBloc
                                    .add(CartDecreaseItemQuantityEvent(
                                    widget.cartItemList[widget.index].id,
                                    widget.totalAmount,
                                  ))
                                : () {};
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color:
                                  widget.cartItemList[widget.index].quantity > 1
                                      ? Colors.black
                                      : Colors.black12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //remove button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              widget._cartBloc.add(CartRemoveItemEvent(
                                widget.cartItemList[widget.index].id,
                                widget.totalAmount,
                              ));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 35,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
