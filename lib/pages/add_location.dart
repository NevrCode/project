import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/location_model.dart';
import 'package:project/pages/saved_location.dart';
import 'package:project/services/location_provider.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  var uuid = Uuid();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _rt = TextEditingController();
  final TextEditingController _rw = TextEditingController();
  final TextEditingController _no = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _camat = TextEditingController();
  final TextEditingController _addressName = TextEditingController();

  void addLocation(BuildContext ctx) async {
    print(supabase.auth.currentUser!.id);
    Provider.of<LocationProvider>(ctx, listen: false).addData({
      'location_id': uuid.v1(),
      'location_name': _addressName.text,
      'street_name': _street.text,
      'rt_number': _rt.text,
      'rw_number': _rw.text,
      'street_number': _no.text,
      'kecamatan': _camat.text,
      'kabupaten_or_kota': _kota.text,
      'user_id': supabase.auth.currentUser!.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CostumText(data: "Tambah lokasi baru"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  // Tombol Upload Foto
                  CostumTextField(
                      controller: _addressName,
                      radius: 12,
                      icon: Icons.person_pin_circle_rounded,
                      labelText: "Address name"),
                  CostumTextField(
                      controller: _street,
                      radius: 12,
                      icon: Icons.streetview,
                      labelText: "Address name"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CostumText(data: "RT/RW"),
                      SizedBox(
                        width: 130,
                        child: CostumTextField(
                          padding: EdgeInsets.fromLTRB(18, 8, 8, 18),
                          controller: _rt,
                          radius: 12,
                          labelText: "",
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: CostumTextField(
                            padding: EdgeInsets.fromLTRB(8, 8, 18, 18),
                            controller: _rw,
                            radius: 12,
                            inputType: TextInputType.number,
                            labelText: ""),
                      ),
                    ],
                  ),
                  CostumTextField(
                    padding: EdgeInsets.fromLTRB(18, 8, 8, 18),
                    controller: _no,
                    radius: 12,
                    icon: Icons.numbers,
                    labelText: "No.",
                    inputType: TextInputType.number,
                  ),
                  CostumTextField(
                      controller: _camat, radius: 12, labelText: "kecamatan"),
                  CostumTextField(
                      controller: _kota, radius: 12, labelText: "Kota"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(150, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 252, 252, 252)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SaveLocationPage()));
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
                              color: Color.fromARGB(255, 32, 32, 32),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(140, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 255, 238, 0)),
                            elevation: WidgetStateProperty.all(2),
                          ),
                          onPressed: () => {addLocation(context)},
                          child: const Text(
                            'Tambah ',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                fontSize: 15,
                                color: Color.fromARGB(255, 29, 29, 29)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
