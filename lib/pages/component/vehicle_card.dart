import 'package:flutter/material.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:project/pages/detail.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      vehicle: vehicle,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 3, 6, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Card(
            elevation: 0.3,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        vehicle.picURL,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          vehicle.modelName,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Gotham-regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
