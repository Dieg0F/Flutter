import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/view/bills/bills-bloc.dart';
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
    //setPriceCountAnimation();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = _controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Meus Gastos"),
      body: body(),
      floatingActionButton: widgets.floatingActionButton(
        Icons.add,
        action: () {
          Routes(context: context).toAddBill();
        },
      ),
    );
  }

  Container body() {
    bloc.getBills();
    return Container(
      child: StreamBuilder<List<Bill>>(
        stream: bloc.subject.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Bill>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              var bills = snapshot.data;
              return Column(
                children: <Widget>[
                  billsTotal(bills),
                  billsList(bills),
                ],
              );
            } else {
              return Center(
                child: widgets.basicText("isEmpty", 35, Colors.black26),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container billsTotal(List<Bill> bills) {
    double total = 0;
    bills.forEach((item) => total += item.price);
    _controller.forward(from: 0.0);
    updateTotalPriceCount(total);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: widgets.basicText("Total que gastei", 25, Colors.black26),
              padding: new EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            ),
            Container(
              child: new AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget child) {
                  return widgets.basicText(
                      "R\$ ${_animation.value.toStringAsFixed(1)}",
                      35,
                      Colors.red);
                },
              ),
              padding: new EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.05),
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }

  void updateTotalPriceCount(double total) {
    _animation = new Tween<double>(
      begin: _animation.value,
      end: total,
    ).animate(new CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: _controller,
    ));
  }

  Container billsList(List<Bill> bills) {
    return Container(
      child: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (BuildContext context, int index) {
          var bill = bills[index];
          return Dismissible(
            child: billItemList(bill),
            key: Key(UniqueKey().toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              child: Icon(
                Icons.delete_forever,
                color: Colors.white70,
              ),
              color: Colors.red.withOpacity(0.8),
            ),
            onDismissed: (direction) {
              bloc.removeBill(bill);
            },
          );
        },
      ),
      height: (MediaQuery.of(context).size.height * 0.8) - 83.3,
    );
  }

  Container billItemList(Bill bill) {
    return Container(
      child: InkResponse(
        onTap: () {
          Routes(context: context).toBillDetails(bill);
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: widgets.basicText(bill.name, 18, Colors.black54),
                padding: new EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              ),
              Container(
                child: widgets.basicText(bill.where, 14, Colors.black26),
                padding: new EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
              ),
              Container(
                child: widgets.basicText("R\$ ${bill.price}", 28, Colors.red),
                padding: new EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              ),
            ],
          ),
          padding: new EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
              bottom: BorderSide(
                color: Colors.black12,
                style: BorderStyle.solid,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width,
    );
  }
}
