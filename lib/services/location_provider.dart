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
      locations[res[i]["location_id"]] = res[i];
    }
    print(locations);
    notifyListeners();
  }

  Future<void> addData(Map<String, dynamic> locationModel) async {
    locations[locationModel['location_id']] = locationModel;
    await supabase.from('locations').insert(locationModel);
    notifyListeners();
  }

  // cara pakenya itu update dlu model baru pass ke sini
  Future<void> updateData(Map<String, dynamic> modifiedLocation) async {
    locations[modifiedLocation['location_id']] = modifiedLocation;
    await supabase
        .from('locations')
        .update(modifiedLocation)
        .eq('location_id', modifiedLocation['location_id']);
    notifyListeners();
  }
}
