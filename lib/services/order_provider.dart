import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';

class OrderProvider with ChangeNotifier {
  List<LeaseModel> lease = [];

  Future<void> fetchData() async {
    // final res = await supabase.from('')
  }
}
