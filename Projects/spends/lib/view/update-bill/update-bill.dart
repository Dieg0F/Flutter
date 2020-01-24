import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/view/update-bill/update-bill-bloc.dart';
import 'package:spends/view/bills/bills-bloc.dart' as billList;

import 'package:spends/view/widgets/widgets.dart' as widgets;

class UpdateBill extends StatefulWidget {
  Bill bill;
  UpdateBill({Key key, @required this.bill}) : super(key: key);

  _UpdateBillState createState() => _UpdateBillState();
}

class _UpdateBillState extends State<UpdateBill> {
  Bill bill = new Bill();

  FocusNode nameFocus = new FocusNode();
  FocusNode whereFocus = new FocusNode();
  FocusNode whenFocus = new FocusNode();
  FocusNode priceFocus = new FocusNode();

  TextEditingController txNameController = new TextEditingController();
  TextEditingController txWhereController = new TextEditingController();
  TextEditingController txWhenController = new TextEditingController();
  TextEditingController txPriceController = new TextEditingController();

  @override
  void initState() {
    bill = widget.bill;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Nova Conta"),
      body: bodyScroll(),
      floatingActionButton: widgets.floatingActionButton(
        Icons.save,
        action: saveBill,
      ),
    );
  }

  SingleChildScrollView bodyScroll() {
    return SingleChildScrollView(
      child: body(),
    );
  }

  void saveBill() {
    setState(() {
      bill.name = txNameController.text;
      bill.where = txWhereController.text;
      bill.when = txWhenController.text;
      bill.price = double.parse(txPriceController.text);

      bloc.updateBill(bill);
      billList.bloc.getBills();
      Navigator.pop(context);
    });
  }

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          inputDropdownField(
            widgets.basicText(
                "Que tipo de compra foi essa?", 28, Colors.black54),
            dropdownType(),
          ),
          inputField(
            widgets.basicText("Gastei com o que?", 28, Colors.black54),
            inputName(),
          ),
          inputField(
            widgets.basicText("Onde fiz essa compra?", 28, Colors.black54),
            inputWhere(),
          ),
          inputField(
            widgets.basicText("Quando foi isso?", 28, Colors.black54),
            inputWhen(),
          ),
          inputField(
            widgets.basicText("E o preco?", 28, Colors.black54),
            inputPrice(),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
    );
  }

  Container inputField(Text textLabel, TextFormField inputText) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textLabel,
          Flexible(
            child: Container(
              child: inputText,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
      height: 150,
    );
  }

  Container inputDropdownField(Text textLabel, DropdownButton dropdownField) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textLabel,
          Flexible(
            child: Container(
              child: dropdownField,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
      height: 150,
    );
  }

  DropdownButton dropdownType() {
    var hintText = "";
    if (bill.type == null) {
      hintText = "Selecione um tipo";
    } else {
      hintText = bill.type;
    }
    return widgets.categoryDropDown(
        hintText, updateDropdownSelection, bill.type);
  }

  updateDropdownSelection(String option) {
    setState(() {
      bill.type = option;
    });
  }

  TextFormField inputName() {
    txNameController.text = bill.name;
    return TextFormField(
      controller: txNameController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.tealAccent,
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: whereFocus,
      onFieldSubmitted: (String value) {
        bill.name = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(whereFocus);
      },
    );
  }

  TextFormField inputWhere() {
    txWhereController.text = bill.where;
    return TextFormField(
      controller: txWhereController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.tealAccent,
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: whereFocus,
      onFieldSubmitted: (String value) {
        bill.where = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(whenFocus);
      },
    );
  }

  TextFormField inputWhen() {
    txWhenController.text = bill.when;
    return TextFormField(
      controller: txWhenController,
      keyboardType: TextInputType.datetime,
      cursorColor: Colors.tealAccent,
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: whenFocus,
      onFieldSubmitted: (String value) {
        bill.when = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(priceFocus);
      },
    );
  }

  TextFormField inputPrice() {
    txPriceController.text = bill.price.toString();
    return TextFormField(
      controller: txPriceController,
      keyboardType: TextInputType.numberWithOptions(),
      cursorColor: Colors.tealAccent,
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: priceFocus,
      onFieldSubmitted: (String value) {
        bill.name = value;
      },
      onEditingComplete: () {
        saveBill();
      },
    );
  }
}
