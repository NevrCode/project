import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';

class VehicleProvider with ChangeNotifier {
  List<VehicleModel> vehicleList = [];

  Future<void> fetchData() async {
    final res = await supabase.from('vehicles').select('*, categories(*)');
    print(res);
    vehicleList = res.map((e) => VehicleModel.fromMap(e)).toList();
    notifyListeners();
  }
}
