import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/bill-details/bill-details-widget.dart';
import 'package:spends/view/bills/bills-bloc.dart';

import 'package:spends/view/widgets/widgets.dart' as widgets;

class BillDetails extends StatefulWidget {
  Bill bill;
  BillDetails({@required this.bill});

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  BillDetailsWidget billDetailsWidget;

  @override
  Widget build(BuildContext context) {
    billDetailsWidget =
        new BillDetailsWidget(context: context, bill: widget.bill);
    return Scaffold(
      appBar: widgets.appBar("Detalhes da Conta", actions: actionsAppBar()),
      body: billDetailsWidget.body(),
      floatingActionButton:
          widgets.floatingActionButton(Icons.edit, action: () {
        Routes(context: context).toUpdateBill(widget.bill);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  List<Widget> actionsAppBar() {
    return [
      IconButton(
        icon: Icon(Icons.delete, color: Colors.white60),
        onPressed: () {
          bloc.removeBill(widget.bill);
          Navigator.pop(context);
        },
      )
    ];
  }
}
