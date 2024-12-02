// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/add_location.dart';
import 'package:project/pages/component/detail_desc.dart';
import 'package:project/pages/component/vehicle_card.dart';
import 'package:project/util/util.dart';

class SaveLocationPage extends StatefulWidget {
  const SaveLocationPage({super.key});

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends State<SaveLocationPage> {
  @override
  Widget build(BuildContext context) {
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
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 221, 221, 221),
                    ),
                  ),
                ),
                child: ExpansionTile(
                  showTrailingIcon: false,
                  shape:
                      Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                        child: Center(child: CostumText(data: "Nama")),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Center(child: CostumText(data: "Kabupaten")),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Builder(builder: (context) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // pake to map
                                Flexible(
                                  child: DetailDescription(
                                      attribute: "RT", value: "02"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
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
