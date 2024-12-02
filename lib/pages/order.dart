import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';
import 'package:project/model/location_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/services/location_provider.dart';
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
    final locationProvider = Provider.of<LocationProvider>(context);
    String text = locationProvider.locations.toString();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Map<String, dynamic> model =
            LocationModel(locationId: "17d98bbd-e9ed-4338-b1bd-b51084da6e87")
                .toMap();
        model['location_name'] = "abc";
        locationProvider.updateData(model);
        text = locationProvider.locations.toString();
      }),
      body: Center(child: Text(text)),
    );
  }
}
