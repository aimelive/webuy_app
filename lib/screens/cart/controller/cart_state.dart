part of 'cart_controller.dart';

enum WillAccept { yes, no, none }

class CartState extends Equatable {
  final bool showBottomSheet, isRemoving;
  final WillAccept willAccept;
  final List<Food> foods;

  const CartState(
      {required this.showBottomSheet,
      required this.foods,
      required this.willAccept,
      required this.isRemoving});

  CartState copyWith({
    bool? showBottomSheet,
    bool? isRemoving,
    List<Food>? foods,
    WillAccept? willAccept,
  }) {
    return CartState(
      showBottomSheet: showBottomSheet ?? this.showBottomSheet,
      foods: foods ?? this.foods,
      willAccept: willAccept ?? this.willAccept,
      isRemoving: isRemoving ?? this.isRemoving,
    );
  }

  @override
  List<Object?> get props => [showBottomSheet, foods];
}
