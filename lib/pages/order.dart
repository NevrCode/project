// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/lease_model.dart';
import 'package:project/pages/component/detail_desc.dart';
import 'package:project/services/order_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<void> makeOrder() async {
    await supabase.from("lease").insert(LeaseModel(
            id: 123,
            uid: supabase.auth.currentSession!.user.id,
            vehicleId: "10623aea-1128-4604-9daa-ad6421715a23",
            leaseStartDate: DateTime.now(),
            rentalHours: 12)
        .toMap());
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false).lease;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.yellow,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: CostumText(data: "in progress"),
                            ),
                          ),
                        ),
                        CostumText(
                          data: "14 Feb 1994",
                          color: const Color.fromARGB(255, 37, 37, 37),
                          align: TextAlign.end,
                          size: 14,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CostumText(
                              data: "ID",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                          Flexible(
                            child: CostumText(
                              data: "aaaa-bbbb-333-ffff",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CostumText(
                              data: "Items :",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs47xqoqlemOtsdogwGSyWMkIWyR0GPzA5UQ&s",
                              width: 90,
                            ),
                          ),
                          CostumText(data: "Corgi")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CostumText(
                              data: "Location",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                          Flexible(
                            child: CostumText(
                              data: "Jakarta",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CostumText(
                              data: "Rented for",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                          Flexible(
                            child: CostumText(
                              data: "12 Days",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CostumText(
                              data: "Location",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                          Flexible(
                            child: CostumText(
                              data: "Jakarta",
                              color: const Color.fromARGB(255, 37, 37, 37),
                              align: TextAlign.end,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: order.length,
          //   itemBuilder: (context, index) {
          //     return Container();
          //   },
          // )
        ],
      ),
    );
  }
}
