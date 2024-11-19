import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';

class VehicleProvider with ChangeNotifier {
  List<VehicleModel> vehicleList = [];

  // Future<void> fetchData() {
  //   final res = await supabase.from('vehicle').select();
  // }
}
