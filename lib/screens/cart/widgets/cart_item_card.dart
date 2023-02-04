import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webuy_app/models/food.dart';

import '../../../constants/colors.dart';
import '../../../services/payment_services.dart';
import '../controller/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cartController,
    required this.themeMode,
    required this.food,
  }) : super(key: key);

  final CartController cartController;
  final ThemeMode themeMode;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/${food.imgUrl}",
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
                              cartController.onQuantityDecreased(food);
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
                              cartController.onQuantityIncreased(food);
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    onPressed: () async {
                      await PaymentServices(
                        context,
                        food: food,
                        themeMode: themeMode,
                      ).makePayment(
                        amount: (food.price * food.quantity).toInt().toString(),
                        currency: 'USD',
                      );
                    },
                    child: const Text("Pay"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
