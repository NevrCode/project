// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/main.dart';
import 'package:project/model/transaction_model.dart';
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
  bool isLoading = true;
  List<TransactionModel> order = [];
  Future<void> getData() async {
    try {
      final res = await supabase
          .from("transactions")
          .select('*, locations(*)')
          .order('lease_start_date');
      setState(() {
        order = res.map((e) => TransactionModel.fromMap(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order.length,
            itemBuilder: (context, index) {
              final item = order[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderDetailPage(
                              transId: item.id,
                            )));
                  },
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
                                  BorderRadius.all(Radius.circular(12)),
                              color: item.status == "Diproses"
                                  ? const Color.fromARGB(255, 255, 239, 150)
                                  : item.status == "Menunggu Pembayaran"
                                      ? const Color.fromARGB(255, 255, 192, 192)
                                      : const Color.fromARGB(
                                          255, 108, 231, 129),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Center(
                                  child: CostumText(
                                data: item.status,
                                color: const Color.fromARGB(255, 31, 31, 31),
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
                                data: item.id.substring(0, 22),
                                color: const Color.fromARGB(255, 37, 37, 37),
                                align: TextAlign.end,
                                size: 14,
                              ),
                              CostumText(
                                data: item.projectLocation['kabupaten_or_kota'],
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void changeStatus(context, int id, String status) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
  }
}
