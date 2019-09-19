import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/view/add-bill/add-bill.dart';
import 'package:spends/view/bill-details/bill-details.dart';
import 'package:spends/view/update-bill/update-bill.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  void toBillDetails(Bill bill) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillDetails(bill: bill),
      ),
    );
  }

  void toAddBill() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBill(),
      ),
    );
  }

  void toUpdateBill(Bill bill) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateBill(bill: bill),
      ),
    );
  }
}
