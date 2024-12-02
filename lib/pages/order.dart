import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/services/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<void> makeOrder() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    String text = orderProvider.lease.toString();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        // final newOrder = orderProvider.lease["100"];
        // newOrder['id'] = 101;
        orderProvider.modifyLeaseDuration(101, 24);
        text = orderProvider.lease.toString();
      }),
      body: Center(child: Text(text)),
    );
  }
}
