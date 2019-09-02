import 'package:flutter/material.dart';
import 'package:spends/view/widgets/widgets.dart';

class AddBillWidget {
  BuildContext context;

  AddBillWidget({this.context});

  Container body() {
    return Container(
      child: Center(
        child: basicText(
          "Add Bill",
          35,
          Colors.black54,
        ),
      ),
    );
  }
}
