import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/add-bill/add-bill-bloc.dart';
import 'package:spends/view/widgets/widgets.dart';

class BillsWidget {
  BuildContext context;

  BillsWidget({this.context});

  Container body() {
    bloc.getAllBills();
    return Container(
      child: StreamBuilder<Bill>(
        stream: bloc.subject.stream,
        builder: (BuildContext context, AsyncSnapshot<Bill> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Center(
                child: basicButton(
                  snapshot.data.name,
                  action: () {
                    Routes(context: context).toBillDetails(snapshot.data);
                  },
                ),
              );
            } else {
              return Center(
                child: basicButton(
                  "Details 1",
                  action: () {
                    Routes(context: context).toBillDetails(new Bill());
                  },
                ),
              );
            }
          } else {
            return Center(
              child: basicButton(
                "Details 2",
                action: () {
                  Routes(context: context).toBillDetails(new Bill());
                },
              ),
            );
          }
        },
      ),
    );
  }
}
