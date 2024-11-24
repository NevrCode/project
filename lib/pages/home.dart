import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/vehicle_model.dart';
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                VehicleModel vehicle = vehicles[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const DetailPage();
                      }));
                    },
                    child: Card(
                      elevation: 0.3,
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display item image
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  supabase.storage
                                      .from('VehicleImage')
                                      .getPublicUrl(vehicle.picURL),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  // Adjust the height as needed
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // TODO : sesuain dengan desain
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      vehicle.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins-regular',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    vehicle.category,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 114, 114)),
                                  ),
                                  // SizedBox(
                                  //   height: 40,
                                  //   child: Row(
                                  //     children: [
                                  //       Icon(
                                  //         Icons.star_rounded,
                                  //         size: 30,
                                  //         color: Color.fromARGB(
                                  //             255, 253, 235, 72),
                                  //       ),
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets
                                  //                 .only(
                                  //                 left: 8.0),
                                  //         child: Text(
                                  //           '${product.rate.toStringAsFixed(product.rate.truncateToDouble() == product.rate ? 0 : 1)} /5',
                                  //           style: TextStyle(
                                  //             fontFamily:
                                  //                 'Poppins-regular',
                                  //             fontSize: 14,
                                  //             color:
                                  //                 Color.fromARGB(
                                  //                     255,
                                  //                     165,
                                  //                     165,
                                  //                     165),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
