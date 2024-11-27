import 'package:flutter/material.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/component/detail_section.dart';

class DetailVehiclePage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailVehiclePage({super.key, required this.vehicle});

  @override
  State<DetailVehiclePage> createState() => _DetailVehiclePageState();
}

class _DetailVehiclePageState extends State<DetailVehiclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Image.network(widget.vehicle.picURL),
                width: MediaQuery.of(context).size.width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 180,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.vehicle.name,
                                  style: TextStyle(
                                    fontFamily: "Gotham-regular",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.vehicle.category.length,
                            itemBuilder: (context, index) {
                              return DetailSection(
                                attributeName: "aa",
                                attributeValue: "bb",
                              );
                            },
                          ),
                          DetailSection(
                              attributeName: "Berat", attributeValue: '444')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
