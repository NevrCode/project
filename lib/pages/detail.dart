import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_vehicle_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    // data diambil tanpa menggunakan key value, hanya dengan foreach sudah bisa
    Future<DetailVehicleModel> fetchDetail(String id) async {
      final res = await supabase.from('detail').select('*').eq("id", id);
      DetailVehicleModel detail =
          res.map((e) => DetailVehicleModel.fromMap(e)).toList()[0];
      return detail;
    }

    return Scaffold(
      body:
          ElevatedButton(onPressed: () async {}, child: const Text("Click Me")),
    );
  }
}
