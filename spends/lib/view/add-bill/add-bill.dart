import 'package:flutter/material.dart';

import 'add-bill-widget.dart';
import 'package:spends/view/widgets/widgets.dart' as widgets;

class AddBill extends StatefulWidget {
  @override
  _AddBillState createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Bills"),
      body: AddBillWidget(context: context).body(),
    );
  }
}
