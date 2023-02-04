import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webuy_app/constants/shared.dart';
import 'package:webuy_app/constants/themes.dart';
import '../../components/back_button.dart';
import 'controller/cart_controller.dart';
import 'widgets/cart_item_card.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.read(cartProvider.notifier);
    final cartFoods = ref.watch(cartProvider).foods;
    final themeMode = ref.watch(themeModeProvider);

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
                    (food) => CartItemCard(
                      cartController: cartController,
                      themeMode: themeMode,
                      food: food,
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
