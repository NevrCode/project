class VehicleModel {
  String id;
  String name;
  String catId;
  String picURL;
  String category;

  VehicleModel(
      {required this.id,
      required this.name,
      required this.catId,
      required this.picURL,
      required this.category});

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['vehicle_id'],
      name: map['name'],
      catId: map['category_id'],
      category: map['category'],
      picURL: map['picURL'],
    );
  }
}
