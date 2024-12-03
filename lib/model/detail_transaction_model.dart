class DetailTransactionModel {
  String id;
  int quantity;
  Map<String, dynamic> transaction;
  Map<String, dynamic> vehicle;

  DetailTransactionModel(
      {required this.id,
      required this.transaction,
      required this.vehicle,
      required this.quantity});

  factory DetailTransactionModel.fromMap(Map<String, dynamic> map) {
    return DetailTransactionModel(
      id: map['id'] ?? '',
      quantity: map['quantity'] ?? 1,
      transaction: map['transactions'] ?? {},
      vehicle: map['vehicles'] ?? {},
    );
  }
}
