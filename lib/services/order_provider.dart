import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';

class OrderProvider with ChangeNotifier {
  List<LeaseModel> lease = [];

  Future<void> fetchData() async {
    final res = await supabase.from('lease').select("*");
    lease = res.map((e) => LeaseModel.fromMap(e)).toList();
    notifyListeners();
    print(lease);
  }

  Future<void> modifyLeaseDuration(int id, int newDuration) async {
    for (LeaseModel l in lease) {
      if (l.id == id) {
        l.rentalHours = newDuration;
      }
    }
    print(newDuration);
    await supabase
        .from('lease')
        .update({"rental_hours": newDuration}).eq('id', id);
    notifyListeners();
  }

  Future<void> addOrders(List<LeaseModel> newLease) async {
    for (LeaseModel l in newLease) {
      lease.add(l);
    }
    final rows = newLease.map((item) => item.toMap()).toList();
    await supabase.from("lease").insert(rows);
    notifyListeners();
  }
}
