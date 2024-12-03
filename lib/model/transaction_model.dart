import 'package:project/model/vehicle_model.dart';

class TransactionModel {
  String id;
  String userId;
  Map<String, dynamic> projectLocation;
  DateTime leaseStartDate;
  int rentalHours;
  String status;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.projectLocation,
    required this.leaseStartDate,
    required this.rentalHours,
    this.status = "menunggu pembayaran",
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['transaction_id'] as String,
        userId: map['user_id'] as String,
        projectLocation: map['locations'],
        leaseStartDate: DateTime.parse(map['lease_start_date'] as String),
        rentalHours: map['rental_hours'] as int,
        status: map['status'] as String);
  }

// add in multi table
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': userId,
      'project_location': projectLocation,
      'lease_start_date': leaseStartDate.toIso8601String(),
      'rental_hours': rentalHours,
      'status': status,
    };
  }
}
