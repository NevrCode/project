// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/add_location.dart';
import 'package:project/pages/component/detail_desc.dart';
import 'package:project/pages/component/vehicle_card.dart';
import 'package:project/services/location_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

class SaveLocationPage extends StatefulWidget {
  const SaveLocationPage({super.key});

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends State<SaveLocationPage> {
  @override
  Widget build(BuildContext context) {
    final alamat =
        Provider.of<LocationProvider>(context, listen: false).locations;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 254, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 254, 251),
        title: CostumText(data: "Saved Location"),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: alamat.length,
            itemBuilder: (context, index) {
              final a = alamat[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 221, 221, 221),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // pake to map
                          Flexible(
                            child: CostumText(
                              data: a.locationName!,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                      child: CostumText(
                        data:
                            "jl.${a.streetName} RT ${a.rtNumber}/RW ${a.rwNumber} no.${a.streetNumber}, ${a.kecamatan}, ${a.kabupatenOrKota}",
                        size: 14,
                        color: const Color.fromARGB(255, 151, 151, 151),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 8, 0),
            child: MyButton(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AddLocationPage()));
                },
                width: 200,
                height: 40,
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.add,
                        color: const Color.fromARGB(255, 87, 87, 87),
                      ),
                      CostumText(data: "tambah lokasi"),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
