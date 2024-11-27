class DetailVehicleModel {
  String id;
  String description;
  Map<String, dynamic> specification;

  DetailVehicleModel(
      {required this.id,
      required this.description,
      required this.specification});

  factory DetailVehicleModel.fromMap(Map<String, dynamic> map) {
    return DetailVehicleModel(
        id: map['id'],
        description: map['description'],
        specification: map['specification']);
  }
}
