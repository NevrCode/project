import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
    // Initialize Stripe elements
    Stripe.instance.applySettings();
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(
          amount,
        ),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _makePayment() async {
    try {
      // Create a PaymentIntent
      final paymentIntent = await _createPaymentIntent();

      // Confirm the PaymentIntent
      await Stripe.instance.confirmPayment(
        paymentIntent['client_secret'], // client_secret from the backend
        PaymentMethodParams.card(),
      );

      // Show success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Successful!')),
      );
    } catch (e) {
      // Handle error
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
