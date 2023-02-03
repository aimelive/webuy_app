import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/constants/colors.dart';
import 'package:webuy_app/constants/shared.dart';
import '../../components/back_button.dart';
import 'controller/cart_controller.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.read(cartProvider.notifier);
    final cartFoods = ref.watch(cartProvider).foods;
    // final isDark = ref.read(themeModeProvider.notifier).isDarkTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GoBackButton(),
            verticalSpace(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Checkout Products",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                ),
              ),
            ),
            verticalSpace(10.h),
            Column(
              children: cartFoods
                  .map(
                    (food) => Dismissible(
                      onDismissed: (direction) {
                        cartController.onRemoveCart(food);
                      },
                      key: ObjectKey(food.id),
                      direction: DismissDirection.endToStart,
                      background: Container(),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 30.sp,
                              color: white,
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                color: white,
                                fontSize: 16.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                      child: Container(
                        height: 100.h,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 5.h,
                        ),
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                offset: const Offset(5, 5),
                                blurRadius: 20,
                              )
                            ]),
                        child: Row(
                          children: [
                            Image.network(
                              food.imgUrl,
                              width: 130.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.title,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${food.currency} ${food.price * food.quantity}",
                                      style: const TextStyle(color: grey),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (food.quantity > 1) {
                                              cartController
                                                  .onQuantityDecreased(food);
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: grey,
                                            size: 25.sp,
                                          ),
                                        ),
                                        Text(
                                          " ${food.quantity} ",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (food.quantity < 10) {
                                              cartController
                                                  .onQuantityIncreased(food);
                                            }
                                          },
                                          child: Icon(
                                            Icons.add_circle,
                                            color: grey,
                                            size: 25.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartController.onRemoveCart(food);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 25.sp,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text("Pay"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "No more products in Cart",
              ),
            )
          ],
        ),
      ),
    );
  }
}
