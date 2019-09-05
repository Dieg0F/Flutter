import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/routes/routes.dart';
import 'package:spends/utils/categories/categories.dart';
import 'package:spends/view/bills/bills-bloc.dart';

import 'package:spends/view/widgets/widgets.dart' as widgets;

class BillDetails extends StatefulWidget {
  Bill bill;
  BillDetails({@required this.bill});

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails>
    with SingleTickerProviderStateMixin {
  Bill bill = new Bill();

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
    bill = widget.bill;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Detalhes da Conta", actions: actionsAppBar()),
      body: body(),
      floatingActionButton:
          widgets.floatingActionButton(Icons.edit, action: () {
        Routes(context: context).toUpdateBill(widget.bill);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  List<Widget> actionsAppBar() {
    return [
      IconButton(
        icon: Icon(Icons.delete, color: Colors.white60),
        onPressed: () {
          bloc.removeBill(widget.bill);
          Navigator.pop(context);
        },
      )
    ];
  }

  Container body() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            billCategory(),
            billDescription(),
            itemPrice(),
          ],
        ),
      ),
    );
  }

  Container billCategory() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(getIconByCategory(bill.type)),
          ),
          Center(
            child: Container(
              child: widgets.basicText(bill.type, 20, Colors.black38),
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ],
      ),
      height: 180,
    );
  }

  Container billDescription() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          billNameDescription(),
          billWhereDescription(),
          billWhenDescription(),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Container billNameDescription() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widgets.basicText("Com o que gastei?", 30, Colors.black45),
          widgets.basicText(bill.name, 26, Colors.black26),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  Container billWhereDescription() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widgets.basicText("E onde foi isso?", 30, Colors.black45),
          widgets.basicText(bill.where, 26, Colors.black26),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  Container billWhenDescription() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widgets.basicText("Em que dia?", 30, Colors.black45),
          widgets.basicText(bill.when, 26, Colors.black26),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  Container itemPrice() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          widgets.lightText(
            "Valor gasto",
            22,
            Colors.black26,
          ),
          new AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return widgets.basicText(
                "R\$ ${_animation.value.toStringAsFixed(1)}",
                60,
                Colors.red,
              );
            },
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
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
}
