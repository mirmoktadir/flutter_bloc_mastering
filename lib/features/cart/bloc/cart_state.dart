part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<Products> cartItems;

  CartSuccessState({required this.cartItems});
}
