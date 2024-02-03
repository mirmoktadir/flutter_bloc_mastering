import 'package:flutter/material.dart';
import 'package:flutter_bloc_mastering/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_mastering/features/home/models/product_model.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(
      {super.key, required this.products, required this.homeBloc});
  final Products products;
  final HomeBloc homeBloc;
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
                          homeBloc
                              .add(CartButtonClickEvent(products: products));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)),
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
