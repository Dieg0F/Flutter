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
  Animation<double> _mAnimation;

  @override
  initState() {
    //setPriceCountAnimation();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = _controller;
    _mAnimation = _controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Minhas contas", actions: actionsAppBar()),
      body: body(),
      floatingActionButton: widgets.floatingActionButton(
        Icons.add,
        action: () {
          Routes(context: context).toAddBill();
        },
      ),
    );
  }

  List<Widget> actionsAppBar() {
    return [
      IconButton(
        icon: Icon(Icons.calendar_today, color: Colors.white60),
        onPressed: () {},
      ),
    ];
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.black26,
                    size: 48,
                  ),
                  Container(
                    child: Center(
                      child: widgets.basicText(
                          "Clique no botão abaixo para adicionar uma nova conta!",
                          25,
                          Colors.black26),
                    ),
                    padding: new EdgeInsets.all(20),
                  ),
                ],
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
    double money = 3369.0;
    bills.forEach((item) => total += item.price);
    _controller.forward(from: 0.0);
    updateTotalPriceCount(total);
    _controller.forward(from: 0.0);
    updateTotalMoneyPriceCount((money - total));
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child:
                      widgets.basicText("Gasto neste mês", 20, Colors.black26),
                  padding: new EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                ),
                Container(
                  child: new AnimatedBuilder(
                    animation: _animation,
                    builder: (BuildContext context, Widget child) {
                      return widgets.basicText(
                          "R\$ ${_animation.value.toStringAsFixed(1)}",
                          28,
                          Colors.red[400]);
                    },
                  ),
                  padding: new EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: widgets.basicText(
                      "Disponivel no mês", 20, Colors.black26),
                  padding: new EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                ),
                Container(
                  child: new AnimatedBuilder(
                    animation: _mAnimation,
                    builder: (BuildContext context, Widget child) {
                      return widgets.basicText(
                          "R\$ ${_mAnimation.value.toStringAsFixed(1)}",
                          28,
                          Colors.green[400]);
                    },
                  ),
                  padding: new EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                ),
              ],
            ),
          ),
        ],
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
      height: MediaQuery.of(context).size.height * 0.15,
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

  void updateTotalMoneyPriceCount(double total) {
    _mAnimation = new Tween<double>(
      begin: _mAnimation.value,
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
                child: widgets.basicText(
                    "R\$ ${bill.price}", 28, Colors.purple[300]),
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
