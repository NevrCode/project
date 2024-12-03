import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_transaction_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/index.dart';
import 'package:project/pages/order.dart';
import 'package:project/services/order_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.transId});
  final String transId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<DetailTransactionModel> vehicle = [];
  bool isLoading = true;
  double total = 10.0;
  Future<void> updateStatus(String status) async {
    await supabase.from('transactions').update({'status': status}).eq(
        'transaction_id', vehicle[0].transaction['transaction_id']);
    if (mounted) {
      await getdetail();
    }
  }

  Future<void> getdetail() async {
    try {
      final res = await supabase
          .from("detail_transactions")
          .select('*, vehicles(*), transactions(*, locations(*))')
          .eq("transaction_id", widget.transId);
      setState(() {
        vehicle = res.map((e) => DetailTransactionModel.fromMap(e)).toList();
        isLoading = false;
      });
      makeTotal();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  void makeTotal() {
    double t = 0.0;
    for (var element in vehicle) {
      var rentPrice = element.vehicle['rent_price_hourly'];
      var rentTime = element.transaction['rental_hours'];
      var opCost = element.vehicle['operator_price_daily'];
      var day = (rentTime ~/ 24) + 1;

      t += (rentTime * rentPrice) + (opCost * day);
    }
    total = t;
  }

  @override
  void initState() {
    super.initState();
    getdetail();
    makeTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CostumText(data: "Detail Pesanan"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 235, 212, 13),
              ), // Show loader while loading
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: vehicle[0].transaction['status'] ==
                                "Menunggu Pembayaran"
                            ? const Color.fromARGB(255, 255, 225, 225)
                            : vehicle[0].transaction['status'] == "Diproses"
                                ? const Color.fromARGB(255, 255, 239, 150)
                                : const Color.fromARGB(255, 166, 240, 156),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CostumText(
                                  data: vehicle[0].transaction['status'],
                                  color: const Color.fromARGB(255, 48, 48, 48),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 248, 248, 248),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CostumText(
                                  data: vehicle[0].transaction['locations']
                                      ['location_name'],
                                ),
                              ],
                            ),
                            CostumText(
                              data:
                                  "jl.${vehicle[0].transaction['locations']['street_name']} RT ${vehicle[0].transaction['locations']['rt_number']}/RW ${vehicle[0].transaction['locations']['rw_number']} no.${vehicle[0].transaction['locations']['street_number']}, ${vehicle[0].transaction['locations']['kecamatan']}, ${vehicle[0].transaction['locations']['kabupaten_or_kota']}",
                              size: 14,
                              color: const Color.fromARGB(255, 151, 151, 151),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: const Color.fromARGB(255, 250, 227, 96),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CostumText(
                                  data:
                                      vehicle[0].transaction['transaction_id'],
                                  size: 13,
                                  color: const Color.fromARGB(255, 92, 92, 92),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vehicle.length,
                      itemBuilder: (context, index) {
                        var item = vehicle[index];
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0.1, 0.1),
                                                    blurRadius: 1)
                                              ],
                                            ),
                                            child: Image.network(
                                              item.vehicle['vehicle_img'],
                                              width: 102,
                                              height: 102,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0, top: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CostumText(
                                              data: item.vehicle['model_name'],
                                              color: const Color.fromARGB(
                                                  255, 104, 104, 104),
                                              size: 13,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CostumText(
                                                  data:
                                                      "${item.transaction['rental_hours'].toString()} Jam (${item.transaction['rental_hours'] ~/ 24} Hari)",
                                                  color: const Color.fromARGB(
                                                      255, 138, 138, 138),
                                                  size: 13,
                                                ),
                                              ],
                                            ),
                                            CostumText(
                                              data:
                                                  '${formatCurrency(item.vehicle['rent_price_hourly'].toString())}/ jam',
                                              size: 13,
                                              color: const Color.fromARGB(
                                                  255, 143, 143, 143),
                                            ),
                                            CostumText(
                                              data:
                                                  'Operator : ${formatCurrency(item.vehicle['operator_price_daily'].toString())}/ hari',
                                              size: 13,
                                              color: const Color.fromARGB(
                                                  255, 143, 143, 143),
                                            ),
                                            CostumText(
                                              data:
                                                  "${item.quantity.toString()}x",
                                              color: const Color.fromARGB(
                                                  255, 138, 138, 138),
                                              size: 13,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        color: const Color.fromARGB(255, 243, 243, 243),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CostumText(data: "total"),
                            CostumText(
                              data: formatCurrency(total.toString()),
                              color: vehicle[0].transaction['status'] ==
                                      "Menunggu Pembayaran"
                                  ? const Color.fromARGB(255, 185, 0, 0)
                                  : Color.fromARGB(255, 46, 46, 46),
                            ),
                          ],
                        ),
                      ),
                    ),
                    vehicle[0].transaction['status'] == "Menunggu Pembayaran"
                        ? Padding(
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
                                  overlay:
                                      const Color.fromARGB(115, 240, 130, 130),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.arrow_back,
                                          color: const Color.fromARGB(
                                              255, 202, 43, 43)),
                                      CostumText(
                                        data: "Back  ",
                                        color: const Color.fromARGB(
                                            255, 116, 116, 116),
                                      )
                                    ],
                                  ),
                                ),
                                MyButton(
                                  onTap: () {
                                    updateStatus("Diproses");
                                  },
                                  elevation: 0,
                                  height: 60,
                                  width: 200,
                                  color: const Color(0xffffd500),
                                  overlay:
                                      const Color.fromARGB(115, 228, 216, 58),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CostumText(
                                        data: "Bayar",
                                        color: const Color.fromARGB(
                                            255, 49, 49, 49),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(Icons.done_all,
                                          color: const Color.fromARGB(
                                              255, 65, 65, 65)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : vehicle[0].transaction['status'] == "Diproses"
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyButton(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      elevation: 0,
                                      height: 60,
                                      width: 100,
                                      color: Colors.white,
                                      overlay: const Color.fromARGB(
                                          115, 240, 130, 130),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.arrow_back,
                                              color: const Color.fromARGB(
                                                  255, 202, 43, 43)),
                                          CostumText(
                                            data: "Back  ",
                                            color: const Color.fromARGB(
                                                255, 116, 116, 116),
                                          ),
                                        ],
                                      ),
                                    ),
                                    MyButton(
                                      onTap: () {
                                        updateStatus("Selesai");
                                      },
                                      elevation: 0,
                                      height: 60,
                                      width: 200,
                                      color: const Color.fromARGB(
                                          255, 59, 240, 74),
                                      overlay: const Color.fromARGB(
                                          115, 228, 216, 58),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CostumText(
                                            data: " Pesanan diterima",
                                            color: const Color.fromARGB(
                                                255, 49, 49, 49),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      elevation: 0,
                                      height: 60,
                                      width: 100,
                                      color: Colors.white,
                                      overlay: const Color.fromARGB(
                                          115, 240, 130, 130),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.arrow_back,
                                              color: Color.fromARGB(
                                                  255, 202, 43, 43)),
                                          CostumText(
                                            data: "Back  ",
                                            color: Color.fromARGB(
                                                255, 116, 116, 116),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            ),
    );
  }
}
