import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';

class CartProvider with ChangeNotifier {
  List<VehicleModel> vehicles = [];

  Future<void> addCart(VehicleModel vehicle) async {
    vehicles.add(vehicle);
    notifyListeners();
  }
}
