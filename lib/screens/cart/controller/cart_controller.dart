import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/food.dart';

part 'cart_state.dart';

final cartProvider = StateNotifierProvider<CartController, CartState>(
  (ref) => CartController(),
);

class CartController extends StateNotifier<CartState> {
  CartController()
      : super(
          const CartState(
            showBottomSheet: false,
            foods: [],
            willAccept: WillAccept.none,
            isRemoving: false,
          ),
        );
  void onShowBottomSheet(bool show) {
    state = state.copyWith(showBottomSheet: show);
  }

  void onAddCart(Food food) {
    final newFoods = state.foods.where((foodA) => foodA.id != food.id).toList();
    newFoods.add(food);
    state = state.copyWith(
      foods: newFoods,
      willAccept: WillAccept.none,
    );
  }

  void onRemoveCart(Food food) {
    final newFoods = state.foods.where((foodA) => foodA.id != food.id).toList();
    state = state.copyWith(
      foods: newFoods,
      willAccept: WillAccept.none,
    );
  }

  void onQuantityIncreased(Food food) {
    state.foods[state.foods.indexWhere((element) => element.id == food.id)] =
        Food(
      id: food.id,
      categoryId: food.categoryId,
      imgUrl: food.imgUrl,
      price: food.price,
      title: food.title,
      quantity: ++food.quantity,
    );
    state = state.copyWith(foods: state.foods);
  }

  void onQuantityDecreased(Food food) {
    state.foods[state.foods.indexWhere((element) => element.id == food.id)] =
        Food(
      id: food.id,
      categoryId: food.categoryId,
      imgUrl: food.imgUrl,
      price: food.price,
      title: food.title,
      quantity: --food.quantity,
    );
    state = state.copyWith(foods: state.foods);
  }

  void onWillAccept(WillAccept willAccept) {
    state = state.copyWith(willAccept: willAccept);
  }

  void onRemoving(bool isRemoving) {
    state = state.copyWith(isRemoving: isRemoving);
  }
}
