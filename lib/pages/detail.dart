import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_vehicle_model.dart';
import 'package:project/model/location_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/component/detail_desc.dart';
import 'package:project/services/order_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final VehicleModel vehicle;
  const DetailPage({super.key, required this.vehicle});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<DetailVehicleModel> _futureDetail;
  final _formKey = GlobalKey<FormState>();
  final _rentController = TextEditingController();
  // final _locationController = TextEditingController();
  LocationModel? selectedLoc;
  List<LocationModel> loc = [];
  bool isLoading = true;
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')));
  }

  Future<void> getLoc() async {
    try {
      final res = await supabase
          .from("locations")
          .select('*')
          .eq("user_id", supabase.auth.currentUser!.id);
      setState(() {
        loc = res.map((e) => LocationModel.fromMap(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<DetailVehicleModel> fetchDetail() async {
    final res =
        await supabase.from('detail').select('*').eq("id", widget.vehicle.id);
    return DetailVehicleModel.fromMap(res[0]);
  }

  @override
  void initState() {
    super.initState();
    getLoc();
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
            const Divider(
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
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 197, 178, 10),
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
                              const CostumText(
                                data: "/hr",
                                color: Color.fromARGB(255, 87, 38, 38),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                          child: Row(
                            children: [
                              const CostumText(
                                data: "min : ",
                                color: Color.fromARGB(255, 156, 156, 156),
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
                              ExpansionTile(
                                title: Center(
                                  child: CostumText(
                                      data:
                                          "${widget.vehicle.category} Detail"),
                                ),
                                children: [
                                  ...dvm.specification.entries.map((e) {
                                    return DetailDescription(
                                      attribute: e.key,
                                      value: e.value.toString(),
                                    );
                                  }).toList(),
                                ],
                              ),
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.arrow_back,
                                    color: Color.fromARGB(255, 202, 43, 43)),
                                CostumText(
                                  data: "Back  ",
                                  color: Color.fromARGB(255, 116, 116, 116),
                                )
                              ],
                            ),
                          ),
                          MyButton(
                            onTap: () async {
                              _showLocationModal(context);
                              // Navigator.pop(context);
                            },
                            elevation: 0,
                            height: 60,
                            width: 240,
                            color: const Color(0xffffd500),
                            overlay: const Color.fromARGB(115, 228, 216, 58),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CostumText(
                                  data: "Add to Cart",
                                  color: Color.fromARGB(255, 49, 49, 49),
                                ),
                                Icon(Icons.shopping_cart_checkout_rounded,
                                    color: Color.fromARGB(255, 65, 65, 65)),
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

  void _showLocationModal(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                        child: TextFormField(
                          style: const TextStyle(fontFamily: "Gotham-regular"),
                          controller: _rentController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Duration",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 75, 75, 75)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 248, 248, 248),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a number';
                            }
                            final number = int.tryParse(value);
                            if (number == null) {
                              return 'Please enter a valid number';
                            }
                            if (number < widget.vehicle.minimumHours) {
                              return 'Minimal ${widget.vehicle.minimumHours} jam untuk menyewa';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CostumText(
                        data: "Location",
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      height: 204,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: loc.length,
                        itemBuilder: (context, index) {
                          final a = loc[index];
                          final isSelected =
                              selectedLoc?.locationName == a.locationName;

                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedLoc = a;
                                // print(selectedLoc); // Debugging
                              });
                              // Navigator.pop(context, selectedLoc);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.white,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 221, 221, 221),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            a.locationName!,
                                            style: TextStyle(
                                              fontFamily: 'Gotham-regular',
                                              fontSize: 18,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(Icons.check,
                                              color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14, 10, 10, 10),
                                    child: Text(
                                      "jl.${a.streetName} RT ${a.rtNumber}/RW ${a.rwNumber} no.${a.streetNumber}, ${a.kecamatan}, ${a.kabupatenOrKota}",
                                      style: const TextStyle(
                                        fontFamily: 'Gotham-regular',
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 151, 151, 151),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                              height: 50,
                              width: 200,
                              color: const Color.fromARGB(255, 255, 211, 65),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  order.addTransaction(
                                      selectedLoc!.locationId,
                                      widget.vehicle,
                                      int.parse(_rentController.text),
                                      1);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor:
                                          Color.fromARGB(255, 108, 221, 42),
                                      content: CostumText(
                                          color: Color.fromARGB(
                                              255, 252, 252, 252),
                                          data: 'Item Berhasil Ditambahkan'),
                                    ),
                                  );
                                }
                              },
                              child: const CostumText(
                                data: "Submit",
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
