import 'package:flutter/material.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/bills/bills-widget.dart';
import 'package:spends/view/widgets/widgets.dart' as widgets;

class Bills extends StatefulWidget {
  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Meus Gastos"),
      body: BillsWidget(context: context).body(),
      floatingActionButton: widgets.floatingActionButton(
        Icons.add,
        action: () {
          Routes(context: context).toAddBill();
        },
      ),
    );
  }
}
