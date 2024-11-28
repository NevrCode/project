import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';

class OrderProvider with ChangeNotifier {
  List<LeaseModel> lease = [];

  Future<void> fetchData() async {
    final res = await supabase.from('lease').select("*");
    lease = res.map((e) => LeaseModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addOrders(LeaseModel newLease) async {
    lease.add(newLease);
    await supabase.from("lease").insert(newLease.toMap());
    notifyListeners();
  }
}
