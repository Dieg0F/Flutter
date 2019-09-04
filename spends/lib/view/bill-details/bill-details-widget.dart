import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/view/widgets/widgets.dart';

class BillDetailsWidget {
  BuildContext context;
  Bill bill;

  BillDetailsWidget({this.context, this.bill});

  Container body() {
    return Container(
      child: Center(
        child: basicText(
          bill.name,
          35,
          Colors.black54,
        ),
      ),
    );
  }
}
