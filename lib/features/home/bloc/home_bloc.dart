import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_mastering/data/cart_items.dart';
import 'package:flutter_bloc_mastering/data/products_mock_data.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../models/product_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<CartButtonClickEvent>(cartButtonClickEvent);
    on<CartButtonNavigateEvent>(cartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    try {
      List<Products>? productsList =
          ProductModel.fromJson(ProductMockJson().productMockData).products;
      emit(HomeLoadingSuccessState(products: productsList ?? []));
    } catch (e) {
      emit(HomeLoadingErrorState());
    }
  }

  FutureOr<void> cartButtonClickEvent(
      CartButtonClickEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.products);

    emit(CartItemAddedState());
  }

  FutureOr<void> cartButtonNavigateEvent(
      CartButtonNavigateEvent event, Emitter<HomeState> emit) {
    Logger().d("Cart navigate clicked");
    emit(CartPageNavigationActionState());
  }
}
