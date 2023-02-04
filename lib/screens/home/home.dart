import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/authentication/controller/authentication_controller.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/constants/shared.dart';
import 'package:webuy_app/models/food.dart';
import 'package:webuy_app/screens/cart/controller/cart_controller.dart';
import 'package:webuy_app/screens/home/widgets/categories_widget.dart';

import 'widgets/checkout_bottom_sheet.dart';
import 'widgets/food_card.dart';
import 'widgets/profile_avatar.dart';

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
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        horizontalSpace(80.w),
                        ProfileAvatar(authUser: authUser)
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
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 650 ? 3 : 2,
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
                              height: 170.h,
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
            CheckoutBottomSheet(
              show: showBottomSheet,
              height: bottomSheetHeight,
              foods: cartFoods,
              controller: cartController,
              isRemoving: isRemoving,
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
