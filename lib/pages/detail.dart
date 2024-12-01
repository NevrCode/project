import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_vehicle_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/component/detail_desc.dart';
import 'package:project/pages/component/icon_box.dart';
import 'package:project/util/util.dart';

class DetailPage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailPage({super.key, required this.vehicle});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<DetailVehicleModel> _futureDetail;

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  Future<DetailVehicleModel> fetchDetail() async {
    final res =
        await supabase.from('detail').select('*').eq("id", widget.vehicle.id);
    return DetailVehicleModel.fromMap(res[0]);
  }

  @override
  void initState() {
    super.initState();
    _futureDetail = fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 248),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.yellow,
        backgroundColor: const Color.fromARGB(255, 255, 253, 248),
        title: Column(
          children: [

            Center(child: CostumText(data: widget.vehicle.modelName)),
            Divider(
              indent: 140,
              endIndent: 140,
            ),

          ],
        ),
      ),
      body: FutureBuilder<DetailVehicleModel>(
        future: _futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 197, 178, 10),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found.'));
          } else {
            final dvm = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: ClipRRect(
                        child: Image.network(
                          widget.vehicle.picURL,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.vehicle.name,
                              style: const TextStyle(
                                  fontFamily: "Gotham-regular", fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                          child: Row(
                            children: [
                              CostumText(
                                data: formatCurrency(
                                    widget.vehicle.rentPriceHourly.toString()),
                                color: const Color.fromARGB(255, 151, 9, 9),
                                size: 18,
                              ),
                              CostumText(
                                data: "/hr",
                                color: const Color.fromARGB(255, 87, 38, 38),
                                size: 16,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                          child: Row(
                            children: [
                              CostumText(
                                data: "min : ",
                                color: const Color.fromARGB(255, 156, 156, 156),
                                size: 16,
                              ),
                              CostumText(
                                data: "${widget.vehicle.minimumHours} Hours",
                                color: const Color.fromARGB(255, 146, 145, 145),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 15, 20),
                              child: Column(
                                children: [
                                  DetailDescription(
                                    attribute: "Model",
                                    value: widget.vehicle.modelName,
                                  ),
                                  DetailDescription(
                                    attribute: "Type",
                                    value: widget.vehicle.category,
                                  ),
                                  DetailDescription(
                                    attribute: "Operator (Daily)",
                                    value: formatCurrency(widget
                                        .vehicle.operatorPriceDaily
                                        .toString()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 230, 230, 230)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 15, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...dvm.specification.entries.map((e) {
                                return DetailDescription(
                                  attribute: e.key,
                                  value: e.value.toString(),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            elevation: 0,
                            height: 60,
                            width: 100,
                            color: Colors.white,
                            overlay: const Color.fromARGB(115, 240, 130, 130),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.arrow_back,
                                    color:
                                        const Color.fromARGB(255, 202, 43, 43)),
                                CostumText(
                                  data: "Back  ",
                                  color:
                                      const Color.fromARGB(255, 116, 116, 116),
                                )
                              ],
                            ),
                          ),
                          MyButton(
                            onTap: () {},
                            elevation: 0,
                            height: 60,
                            width: 200,
                            color: Colors.white,
                            overlay: const Color.fromARGB(115, 228, 216, 58),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CostumText(
                                  data: "Add to Cart",
                                  color:
                                      const Color.fromARGB(255, 116, 116, 116),
                                ),
                                Icon(Icons.shopping_cart_checkout_rounded,
                                    color:
                                        const Color.fromARGB(255, 95, 95, 95)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
