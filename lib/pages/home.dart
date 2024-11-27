import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/component/icon_box.dart';
import 'package:project/pages/detail.dart';
import 'package:project/services/vehicle_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<VehicleProvider>(context).vehicleList;
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 189, 189, 189)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconBox(iconData: Icons.fire_truck),
                              IconBox(iconData: Icons.accessible_forward),
                              IconBox(iconData: Icons.factory),
                              IconBox(iconData: Icons.history),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 16),
                child: Text(
                  "Welcome, ${supabase.auth.currentUser!.userMetadata!["displayName"]}",
                  style: TextStyle(
                    fontFamily: "Gotham-regular",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
