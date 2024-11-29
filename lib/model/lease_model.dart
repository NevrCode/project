class LeaseModel {
  int id;
  String uid;
  String? projectLocation;
  String vehicleId;
  DateTime leaseStartDate;
  int rentalHours;

  LeaseModel({
    required this.id,
    required this.uid,
    this.projectLocation,
    required this.vehicleId,
    required this.leaseStartDate,
    required this.rentalHours,
  });

  factory LeaseModel.fromMap(Map<String, dynamic> map) {
    return LeaseModel(
      id: map['id'] as int,
      uid: map['uid'] as String,
      projectLocation: map['project_location'] as String?,
      vehicleId: map['vehicle_id'] as String,
      leaseStartDate: DateTime.parse(map['lease_start_date'] as String),
      rentalHours: map['rental_hours'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'project_location': projectLocation,
      'vehicle_id': vehicleId,
      'lease_start_date': leaseStartDate.toIso8601String(),
      'rental_hours': rentalHours,
    };
  }

  // debug only
  @override
  String toString() {
    return toMap().toString();
  }
}
