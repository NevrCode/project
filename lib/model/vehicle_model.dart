class VehicleModel {
  String id;
  String name;
  String category;
  String picURL;

  VehicleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.picURL,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['vehicle_id'],
      name: map['vehicle_name'],
      category: map['categories']['category_name'],
      picURL: map['vehicle_img'],
    );
  }
}
