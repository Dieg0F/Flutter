import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/widgets/widgets.dart';

class BillsWidget {
  BuildContext context;

  BillsWidget({this.context});

  Container body() {
    return Container(
      child: Center(
        child: basicButton(
          "Details",
          action: () {
            Routes(context: context).toBillDetails(new Bill());
          },
        ),
      ),
    );
  }
}
