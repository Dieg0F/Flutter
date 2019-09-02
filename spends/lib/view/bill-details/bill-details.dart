import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/view/bill-details/bill-details-widget.dart';

import 'package:spends/view/widgets/widgets.dart' as widgets;

class BillDetails extends StatelessWidget {
  Bill bill;
  BillDetails({@required this.bill})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Bills"),
      body: BillDetailsWidget(context: context).body(),
    );
  }
}
