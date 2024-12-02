class LeaseModel {
  int id;
  String uid;
  String? projectLocation;
  Map<String, dynamic> vehicle;

  DateTime leaseStartDate;
  int rentalHours;
  String status;

  LeaseModel({
    required this.id,
    required this.uid,
    this.projectLocation,
    required this.vehicle,
    required this.leaseStartDate,
    required this.rentalHours,
    this.status = "Diproses",
  });

  factory LeaseModel.fromMap(Map<String, dynamic> map) {
    return LeaseModel(
        id: map['id'] as int,
        uid: map['uid'] as String,
        projectLocation: map['project_location'] as String?,
        vehicle: map['vehicles'] as Map<String, dynamic>,
        leaseStartDate: DateTime.parse(map['lease_start_date'] as String),
        rentalHours: map['rental_hours'] as int,
        status: map['status'] as String);
  }

// add in multi table
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'project_location': projectLocation,
      'vehicle': vehicle,
      'lease_start_date': leaseStartDate.toIso8601String(),
      'rental_hours': rentalHours,
      'status': status,
    };
  }

  // debug only
  @override
  String toString() {
    return toMap().toString();
  }
}
