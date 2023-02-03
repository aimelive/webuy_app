import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:webuy_app/constants/shared.dart';
import 'package:webuy_app/models/food.dart';

class PaymentServices {
  Map<String, dynamic>? paymentIntentData;
  BuildContext context;
  bool mounted = true;
  ThemeMode themeMode;
  Food food;

  PaymentServices(this.context, {required this.food, required this.themeMode});

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          style: themeMode,
          merchantDisplayName: 'Aimelive Ltd',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet();
      } else {
        if (!mounted) return;
        MessageToast.error(context, "Payment intent is null");
      }
    } catch (e, s) {
      MessageToast.error(context, "Exception: $e $s");
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      if (!mounted) return;
      MessageToast.success(
        context,
        "(${food.quantity}) ${food.title} has been paid successfully!",
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        MessageToast.error(
            context, "Error from Stripe: ${e.error.localizedMessage}");
      } else {
        MessageToast.error(context, "Unforeseen error: $e");
      }
    } catch (e) {
      MessageToast.error(context, "Exception: $e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency
      };
      final dio = Dio();

      dio.options.headers = {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
      );

      return response.data;
    } catch (err) {
      MessageToast.error(
        context,
        'Something went wrong while charging user: ${err.toString()}',
      );
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
