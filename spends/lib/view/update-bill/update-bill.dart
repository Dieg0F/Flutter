import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/view/update-bill/update-bill-bloc.dart';
import 'package:spends/view/bills/bills-bloc.dart' as billList;
import 'package:spends/view/update-bill/update-bill-widget.dart';

import 'package:spends/view/widgets/widgets.dart' as widgets;

class UpdateBill extends StatefulWidget {
  Bill bill;
  UpdateBill({Key key, @required this.bill}) : super(key: key);

  _UpdateBillState createState() => _UpdateBillState();
}

class _UpdateBillState extends State<UpdateBill> {
  UpdateBillWidget updateBillWidget = new UpdateBillWidget();

  @override
  Widget build(BuildContext context) {
    updateBillWidget.setContext(context);
    updateBillWidget.bill = widget.bill;
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
      child: updateBillWidget.body(),
    );
  }

  void saveBill() {
    if (updateBillWidget.bill != null) {
      widget.bill.name = updateBillWidget.txNameController.text;
      widget.bill.where = updateBillWidget.txWhereController.text;
      widget.bill.when = updateBillWidget.txWhenController.text;
      widget.bill.price = double.parse(updateBillWidget.txPriceController.text);

      bloc.updateBill(updateBillWidget.bill);
      billList.bloc.getBills();
      Navigator.pop(context);
    }
  }
}
