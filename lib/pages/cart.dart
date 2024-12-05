import 'package:flutter/material.dart';
import 'package:project/services/cart_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const CostumText(data: "Cart"),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: cart.vehicles.length,
            itemBuilder: (context, index) {
              return Text(cart.vehicles[index].modelName);
            },
          )
        ],
      ),
    );
  }
}
