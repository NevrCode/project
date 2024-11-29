import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';
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
    await supabase.from("lease").insert(LeaseModel(
            id: 123,
            uid: supabase.auth.currentSession!.user.id,
            vehicleId: "10623aea-1128-4604-9daa-ad6421715a23",
            leaseStartDate: DateTime.now(),
            rentalHours: 12)
        .toMap());
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        orderProvider.modifyLeaseDuration(2, 13);
        print(orderProvider.lease);
      }),
    );
  }
}
