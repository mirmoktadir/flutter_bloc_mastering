import 'package:flutter/material.dart';

import '../../../home/models/product_model.dart';
import '../../bloc/cart_bloc.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartBloc, required this.products});
  final CartBloc cartBloc;
  final Products products;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(products.imageUrl ?? ""),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        products.description ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text("price: \$ ${products.price.toString()}"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          cartBloc.add(CartItemRemoveEvent(products: products));
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
