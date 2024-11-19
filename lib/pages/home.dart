import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VehicleModel> vehicles = [];
  void fetchVehicle() async {
    final res = await supabase.from('vehicles').select('category(*)');

    vehicles = res.map((e) => VehicleModel.fromMap(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchVehicle();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const Text("Kendaraan"),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                VehicleModel vehicle = vehicles[1];

                return Card(
                  child: Column(
                    children: [
                      Text(vehicle.name),
                      Text(vehicle.id),
                      Text(vehicle.category),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
