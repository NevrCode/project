import 'package:flutter/material.dart';

import 'package:project/main.dart';
import 'package:project/model/location_model.dart';

class LocationProvider with ChangeNotifier {
  Map<String, dynamic> locations = {};
  Future<void> fetchData() async {
    final res = await supabase
        .from('locations')
        .select("*")
        .eq('user_id', supabase.auth.currentUser!.id);
    for (int i = 0; i < res.length; i++) {
      locations[res[i]["id"]] = res[i];
    }
    notifyListeners();
  }

  Future<void> addData(LocationModel locationModel) async {
    locations[locationModel.locationId] = locationModel;
    await supabase.from('locations').insert(locationModel.toMap());
  }

  // cara pakenya itu update dlu model baru pass ke sini
  Future<void> updateData(LocationModel modifiedLocation) async {
    locations[modifiedLocation.locationId] = modifiedLocation;
    await supabase.from('locations').update(modifiedLocation.toMap());
    notifyListeners();
  }
}
