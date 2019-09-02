import 'package:flutter/material.dart';
import 'package:spends/view/widgets/widgets.dart';

class BillDetailsWidget {
  BuildContext context;

  BillDetailsWidget({this.context});

  Container body() {
    return Container(
      child: Center(
        child: basicText(
          "Details",
          35,
          Colors.black54,
        ),
      ),
    );
  }
}
