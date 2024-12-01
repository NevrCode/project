import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';


import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';


class OrderProvider with ChangeNotifier {
  List<LeaseModel> lease = [];

  Future<void> fetchData() async {

    final res = await supabase.from('lease').select("*, vehicles(*)");
    lease = res.map((e) => LeaseModel.fromMap(e)).toList();
    notifyListeners();
    print(lease);
  }

  Future<void> modifyLeaseDuration(int id, int newDuration) async {
    for (var l in lease) {
      if (l.id == id) {
        l.rentalHours = newDuration;
      }
    }
    await supabase
        .from('lease')
        .update({"rental_hours": newDuration}).eq('id', id);
    notifyListeners();
  }

  Future<void> addOrder(LeaseModel leaseToAdd) async {
    lease.add(leaseToAdd);
    await supabase.from("lease").insert(leaseToAdd.toMap());
    notifyListeners();
  }

  Future<void> changeStatus(int leaseId) async {
    for (LeaseModel l in lease) {
      if (l.id == leaseId) {
        l.status = "Selesai";
        await supabase
            .from("lease")
            .update({"status": "Selesai"}).eq('id', l.id);
        break;
      }
    }
    notifyListeners();
  }
