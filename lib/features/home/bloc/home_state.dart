part of 'home_bloc.dart';

@immutable
abstract class HomeState {} // UI Build State

abstract class HomeActionState extends HomeState {} // ACTION state

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<Products> products;

  HomeLoadingSuccessState({required this.products});
}

class HomeLoadingErrorState extends HomeState {}

class CartPageNavigationActionState extends HomeActionState {}

class CartItemAddedState extends HomeActionState {}
