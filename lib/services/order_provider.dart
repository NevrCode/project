import 'package:flutter/material.dart';

import 'package:project/main.dart';
import 'package:deepcopy/deepcopy.dart';
import 'package:project/model/lease_model.dart';

class OrderProvider with ChangeNotifier {
  Map<String, dynamic> lease = {};
  Map<String, dynamic> orderItems = {};

  Future<void> fetchData() async {
    final res = await supabase
        .from('lease')
        .select("*, vehicles(*)")
        .eq('uid', supabase.auth.currentUser!.id);
    Map<String, dynamic> tempLease = {};
    for (int i = 0; i < res.length; i++) {
      tempLease[res[i]["id"].toString()] = res[i];
    }
    lease = tempLease;
    notifyListeners();
    print(lease);
  }

  Future<void> modifyLeaseDuration(int id, int newDuration) async {
    lease[id.toString()]["rental_hours"] = newDuration;
    await supabase
        .from('lease')
        .update({"rental_hours": newDuration}).eq('id', id);
    notifyListeners();
  }

  Future<void> addOrder(Map<String, dynamic> leaseToAdd) async {
    lease[leaseToAdd["id"].toString()] = leaseToAdd;
    Map leaseForDb = leaseToAdd.deepcopy();
    leaseForDb.remove("vehicles");
    await supabase.from("lease").insert(leaseForDb);
    notifyListeners();
  }

  // use Waiting for Payment, Diproses maupun Selesai
  Future<void> changeStatus(int leaseId, String status) async {
    lease[leaseId.toString()]["status"] = status;
    await supabase.from("lease").update({"status": status}).eq('id', leaseId);
    notifyListeners();
  }
}
