// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize Stripe elements
//     Stripe.instance.applySettings();
//   }

//   Future<void> _makePayment() async {
//     try {
//       // Create a PaymentIntent
//       final paymentIntent = await createPaymentIntent();

//       // Confirm the PaymentIntent
//       await Stripe.instance.confirmPayment(
//         paymentIntent['client_secret'], // client_secret from the backend
//         PaymentMethodParams.card(),
//       );

//       // Show success
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment Successful!')),
//       );
//     } catch (e) {
//       // Handle error
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment Failed: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
