// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:project/model/lease_model.dart';
import 'package:project/pages/order_detail.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

import '../services/order_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final expansionController = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final order = orderProvider.lease;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrderDetailPage()));
        },
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: order.length,
              itemBuilder: (context, index) {
                final item = order[index];
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: const Color.fromARGB(255, 221, 221, 221),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: item.status == "Diproses"
                                  ? Colors.yellow
                                  : item.status == "Menunggu Pembayaran"
                                      ? const Color.fromARGB(255, 230, 83, 83)
                                      : Colors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Center(
                                  child: CostumText(
                                data: item.status,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CostumText(
                                data: item.id.toString(),
                                color: const Color.fromARGB(255, 37, 37, 37),
                                align: TextAlign.end,
                                size: 14,
                              ),
                              CostumText(
                                data: DateFormat('EEE, MM-dd-yyyy')
                                    .format(item.leaseStartDate),
                                color: const Color.fromARGB(255, 116, 116, 116),
                                align: TextAlign.end,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void changeStatus(context, int id) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await orderProvider.changeStatus(id);
  }

  void _showConfirmationDialog(BuildContext context, LeaseModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: CostumText(data: "Are you sure?"),
          actions: [
            MyButton(
              color: Colors.white,
              overlay: const Color.fromARGB(255, 235, 226, 226),
              elevation: 0,
              height: 40,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CostumText(data: "No"),
            ),
            MyButton(
              color: const Color.fromARGB(255, 231, 205, 54),
              overlay: const Color.fromARGB(255, 235, 226, 226),
              elevation: 0,
              height: 40,
              onTap: () {
                changeStatus(context, item.id);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: CostumText(data: "Yes"),
            ),
          ],
        );
      },
    );
  }
}
