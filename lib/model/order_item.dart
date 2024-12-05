class OrderItem {
  final String id;
  final String userId;
  final Map<String, dynamic> vehicleId;
  final int quantity;

  OrderItem({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      vehicleId: map['vehicle_id'] as Map<String, dynamic>,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'vehicle_id': vehicleId,
      'quantity': quantity,
    };
  }
}
