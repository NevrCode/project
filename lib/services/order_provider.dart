// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/model/detail_transaction_model.dart';
import 'package:project/model/location_model.dart';
import 'package:project/model/transaction_model.dart';
import 'package:project/model/vehicle_model.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  List<DetailTransactionModel> _item = [];
  List<TransactionModel> _trans = [];

  List<DetailTransactionModel> get item => _item;
  List<TransactionModel> get trans => _trans;

  final transactions = supabase.from('transactions');
  final detailTransactions = supabase.from('detail_transactions');

  Future<List<TransactionModel>> fetchTrans() async {
    final res = await transactions
        .select('*, locations(*)')
        .eq("user_id", supabase.auth.currentUser!.id)
        .eq('status', "Menunggu Pembayaran");

    _trans = res.map((e) => TransactionModel.fromMap(e)).toList();
    return _trans;
  }

  Future<void> addTransaction(
    String locationId,
    VehicleModel vehicles,
    int rentHours,
    int quantity,
  ) async {
    var id = Uuid().v1();
    final now = DateTime.now();

    if (trans.isEmpty) {
      var i = await fetchTrans();
      if (i.isEmpty) {
        var res = await transactions.insert({
          "transaction_id": id,
          "lease_start_date": now.toString(),
          "rental_hours": rentHours,
          "location_id": locationId,
          "status": "Menunggu Pembayaran",
          "user_id": supabase.auth.currentUser!.id,
        });
        if (res != null) {
          print("Error inserting transaction: ${res.message}");
          return; // Exit early if the first query fails
        }
        await detailTransactions.insert({
          "transaction_id": id,
          "vehicle_id": vehicles.id,
          "quantity": quantity,
          "user_id": supabase.auth.currentUser!.id,
        });
      } else {
        await detailTransactions.insert({
          "transaction_id": trans[0].id,
          "vehicle_id": vehicles.id,
          "quantity": quantity,
          "user_id": supabase.auth.currentUser!.id,
        });
      }
    }
  }
  // Future<void> updateStatus(String status) {

  // }
}
