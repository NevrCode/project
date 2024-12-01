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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        final newOrder = orderProvider.lease[0];
        newOrder.id = 100;
        orderProvider.addOrder(newOrder);
        print(orderProvider.lease);
      }),
    );
  }
}
