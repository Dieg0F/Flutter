import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/bills/bills-bloc.dart';
import 'package:spends/view/bills/bills-widget.dart';
import 'package:spends/view/widgets/widgets.dart' as widgets;

class Bills extends StatefulWidget {
  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = _controller;
    super.initState();
  }

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
