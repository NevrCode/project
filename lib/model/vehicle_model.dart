class VehicleModel {
  String id;
  String name;
  String category;
  String picURL;
  String modelName;
  int rentPriceHourly;
  int operatorPriceDaily;
  int minimumHours;

  VehicleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.picURL,
    required this.modelName,
    required this.rentPriceHourly,
    required this.operatorPriceDaily,
    required this.minimumHours,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['vehicle_id'],
      name: map['vehicle_name'],
      category: map['categories']['category_name'],
      picURL: map['vehicle_img'],
      modelName: map['model_name'],
      rentPriceHourly: map['rent_price_hourly'],
      operatorPriceDaily: map['operator_price_daily'],
      minimumHours: map['minimum_hours'],
    );
  }
}
