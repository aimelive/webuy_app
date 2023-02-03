import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/authentication/controller/authentication_controller.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/constants/shared.dart';
import 'package:webuy_app/models/food.dart';
import 'package:webuy_app/screens/cart/cart_view.dart';
import 'package:webuy_app/screens/cart/controller/cart_controller.dart';
import 'package:webuy_app/screens/home/widgets/categories_widget.dart';
import 'package:webuy_app/screens/home/widgets/food_plate.dart';
import 'package:webuy_app/screens/profile/profile.dart';

import '../cart/widgets/delete_item_widget.dart';
import 'widgets/food_card.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authProvider).user;
    final showBottomSheet = ref.watch(cartProvider).showBottomSheet;
    final cartController = ref.read(cartProvider.notifier);
    final cartFoods = ref.watch(cartProvider).foods;
    final willAccept = ref.watch(cartProvider).willAccept;
    final isRemoving = ref.watch(cartProvider).isRemoving;

    double bottomSheetHeight = 190.h;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(22.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hi, What are we eating today?",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        horizontalSpace(80.w),
                        GestureDetector(
                          onTap: () => pushPage(
                            context,
                            to: const Profile(),
                          ),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            foregroundColor: white,
                            radius: 25.r,
                            child: Text(
                              authUser.name == null
                                  ? authUser.email![0]
                                  : authUser.name![0],
                              style: TextStyle(fontSize: 25.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(18.h),
                    const CategoriesWidget(),
                    verticalSpace(14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        "Selected Foods (${foods.length} items)",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18.h,
                        crossAxisSpacing: 17.w,
                      ),
                      shrinkWrap: true,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return Draggable<Food>(
                          data: foods[index],
                          onDragStarted: () {
                            if (!showBottomSheet) {
                              cartController
                                  .onShowBottomSheet(!showBottomSheet);
                            }
                          },
                          childWhenDragging: FoodCardWidget(
                            food: foods[index],
                            isDragging: true,
                          ),
                          feedback: Material(
                            borderRadius: BorderRadius.circular(16.r),
                            elevation: 2,
                            color: willAccept == WillAccept.yes
                                ? primaryColor
                                : willAccept == WillAccept.no
                                    ? Colors.red
                                    : null,
                            child: Container(
                              width: 160.w,
                              height: 165.h,
                              padding: EdgeInsets.all(5.r),
                              child: FoodCardWidget(food: foods[index]),
                            ),
                          ),
                          child: FoodCardWidget(food: foods[index]),
                        );
                      },
                    ),
                    verticalSpace(
                      showBottomSheet ? bottomSheetHeight - 12.h : 0,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: showBottomSheet ? bottomSheetHeight : 0.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: cartFoods.isEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => cartController.onShowBottomSheet(false),
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
                      cartController.onAddCart(data);
                    },
                    onLeave: (data) {
                      cartController.onWillAccept(WillAccept.none);
                    },
                    onWillAccept: (data) {
                      final bool willAccept = !cartFoods.contains(data);
                      if (willAccept) {
                        cartController.onWillAccept(WillAccept.yes);
                      } else {
                        cartController.onWillAccept(WillAccept.no);
                      }
                      return willAccept;
                    },
                    builder: (context, accepted, rejected) {
                      return Container(
                        height: 100.h,
                        color: Theme.of(context).backgroundColor,
                        child: ListView.builder(
                          itemCount: cartFoods.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                FoodPlateWidget(
                                  food: cartFoods[index],
                                ),
                                if (isRemoving)
                                  GestureDetector(
                                    onTap: () => cartController.onRemoveCart(
                                      cartFoods[index],
                                    ),
                                    child: CircleAvatar(
                                      radius: 12.r,
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor:
                                          Theme.of(context).cardColor,
                                      child: const Icon(Icons.remove),
                                    ),
                                  )
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  if (cartFoods.isNotEmpty)
                    DeleteItemFromCart(
                      onRemoveClicked: () =>
                          cartController.onRemoving(!isRemoving),
                      onCheckoutClicked: () {
                        cartController.onShowBottomSheet(!showBottomSheet);
                        pushPage(context, to: const CartView());
                      },
                      isRemoving: isRemoving,
                      cartFoods: cartFoods.length,
                    )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: showBottomSheet
          ? null
          : Stack(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    cartController.onShowBottomSheet(!showBottomSheet);
                  },
                  highlightElevation: 0.0,
                  backgroundColor: primaryColor,
                  foregroundColor: white,
                  elevation: 0.0,
                  mouseCursor: MaterialStateMouseCursor.textable,
                  tooltip: 'Cart',
                  child: const Icon(Icons.shopping_cart),
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: white,
                    radius: 15.r,
                    child: Text(
                      cartFoods.length.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
