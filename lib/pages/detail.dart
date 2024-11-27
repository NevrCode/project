import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_vehicle_model.dart';
import 'package:project/model/vehicle_model.dart';

class DetailPage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailPage({super.key, required this.vehicle});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // data diambil tanpa menggunakan key value, hanya dengan foreach sudah bisa
    Future<DetailVehicleModel> fetchDetail() async {
      final res =
          await supabase.from('detail').select('*').eq("id", widget.vehicle.id);
      DetailVehicleModel detail =
          res.map((e) => DetailVehicleModel.fromMap(e)).toList()[0];
      return detail;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle.modelName),
      ),
      body: Column(
        children: [Image.network(widget.vehicle.picURL)],
      ),
    );
  }
}
