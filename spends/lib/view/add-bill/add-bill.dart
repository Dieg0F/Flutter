import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'add-bill-bloc.dart';
import 'add-bill-widget.dart';
import 'package:spends/view/widgets/widgets.dart' as widgets;

class AddBill extends StatefulWidget {
  @override
  _AddBillState createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  AddBillWidget addBillWidgets = new AddBillWidget();

  @override
  Widget build(BuildContext context) {
    addBillWidgets.setContext(context);
    return Scaffold(
      appBar: widgets.appBar("Nova Conta"),
      body: bodyScroll(),
      floatingActionButton: widgets.floatingActionButton(
        Icons.save,
        action: saveBill,
      ),
    );
  }

  SingleChildScrollView bodyScroll() {
    return SingleChildScrollView(
      child: addBillWidgets.body(),
    );
  }

  void saveBill() {
    print(addBillWidgets.bill);
    if (addBillWidgets.bill != null) {
      bloc.saveBill(addBillWidgets.bill);
      Navigator.pop(context);
    }
  }
}
