import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/shared.dart';
import '../../../models/food.dart';
import '../../cart/cart_view.dart';
import '../../cart/controller/cart_controller.dart';
import 'delete_item_widget.dart';
import 'food_plate.dart';

class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({
    Key? key,
    required this.show,
    required this.height,
    required this.foods,
    required this.controller,
    required this.isRemoving,
  }) : super(key: key);

  final bool show;
  final double height;
  final List<Food> foods;
  final CartController controller;
  final bool isRemoving;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: show ? height : 0.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: foods.isEmpty
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => controller.onShowBottomSheet(false),
            child: Container(
              width: 40.w,
              height: 8.h,
              margin: EdgeInsets.symmetric(vertical: 3.h),
              decoration: ShapeDecoration(
                color: Theme.of(context).shadowColor,
                shape: const StadiumBorder(),
                shadows: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 5),
                    blurRadius: 24,
                  )
                ],
              ),
            ),
          ),
          DragTarget<Food>(
            onAccept: (data) {
              controller.onAddCart(data);
            },
            onLeave: (data) {
              controller.onWillAccept(WillAccept.none);
            },
            onWillAccept: (data) {
              final bool willAccept = !foods.contains(data);
              if (willAccept) {
                controller.onWillAccept(WillAccept.yes);
              } else {
                controller.onWillAccept(WillAccept.no);
              }
              return willAccept;
            },
            builder: (context, accepted, rejected) {
              return Container(
                height: 100.h,
                color: Theme.of(context).backgroundColor,
                child: ListView.builder(
                  itemCount: foods.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        FoodPlateWidget(
                          food: foods[index],
                        ),
                        if (isRemoving)
                          GestureDetector(
                            onTap: () => controller.onRemoveCart(
                              foods[index],
                            ),
                            child: CircleAvatar(
                              radius: 12.r,
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Theme.of(context).cardColor,
                              child: Icon(
                                Icons.remove,
                                size: 24.sp,
                              ),
                            ),
                          )
                      ],
                    );
                  }),
                ),
              );
            },
          ),
          if (foods.isNotEmpty)
            DeleteItemFromCart(
              onRemoveClicked: () => controller.onRemoving(!isRemoving),
              onCheckoutClicked: () {
                controller.onShowBottomSheet(!show);
                pushPage(context, to: const CartView());
              },
              isRemoving: isRemoving,
              foods: foods.length,
            )
        ],
      ),
    );
  }
}
