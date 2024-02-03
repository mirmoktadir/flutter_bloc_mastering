part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class CartButtonClickEvent extends HomeEvent {
  final Products products;

  CartButtonClickEvent({required this.products});
}

class CartButtonNavigateEvent extends HomeEvent {}
