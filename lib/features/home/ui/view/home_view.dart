import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_mastering/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_mastering/features/home/ui/widgets/product_tile.dart';

import '../../../cart/ui/view/cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is CartPageNavigationActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartView()));
        } else if (state is CartItemAddedState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item added to the Cart!")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Products"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(CartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductTile(
                      products: successState.products[index],
                      homeBloc: homeBloc,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemCount: successState.products.length),
            );
          case HomeLoadingErrorState:
            return const Scaffold(
              body: Center(
                child: Text("Some error happened!"),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
