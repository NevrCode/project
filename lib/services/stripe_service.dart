import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import "package:http/http.dart" as http;

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
          amount * 100, "idr"); // stripe accepts cents
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "HeavyHub",
        ),
      );
      await _processPayment();
      print("done");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      final response = await http.post(url, headers: {
        "Authorization":
            "Bearer sk_test_51QRpopAuTZ1Aldd1IQMbs2SHD3oznUkjPhFhpOu9Z8cJqSwvAdLPYzwzxxxBAi6N6gQxzaRx4Blw66bD7m2LD7ub00j2bVBkgR",
        "Content-Type": 'application/x-www-form-urlencoded'
      }, body: {
        "amount": amount,
        "currency": currency,
        "payment_method_types": ["card"],
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
      final paymentIntent = json.decode(response.body);
      final clientSecret = paymentIntent['client_secret'];

      // Step 2: Confirm the PaymentIntent
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print(e);
    }
  }
}
