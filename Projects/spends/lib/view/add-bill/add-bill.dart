import 'package:flutter/material.dart';
import 'package:spends/model/bill.dart';
import 'package:spends/utils/categories/categories.dart';

import 'add-bill-bloc.dart';
import 'package:spends/view/widgets/widgets.dart' as widgets;

class AddBill extends StatefulWidget {
  @override
  _AddBillState createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  Bill bill = new Bill();

  FocusNode nameFocus = new FocusNode();
  FocusNode whereFocus = new FocusNode();
  FocusNode whenFocus = new FocusNode();
  FocusNode priceFocus = new FocusNode();

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
      bloc.saveBill(bill);
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
            widgets.basicText("Gastei com o que?", 26, Colors.black54),
            inputName(),
          ),
          inputField(
            widgets.basicText("Onde fiz essa compra?", 26, Colors.black54),
            inputWhere(),
          ),
          inputField(
            widgets.basicText("Quando foi isso?", 26, Colors.black54),
            inputWhen(),
          ),
          inputField(
            widgets.basicText("E o preco?", 26, Colors.black54),
            inputPrice(),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
    );
  }

  Container inputField(Text textLabel, TextField inputText) {
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

  TextField inputName() {
    return TextField(
      onChanged: (String value) {
        bill.name = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.teal[200],
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(whereFocus);
      },
    );
  }

  TextField inputWhere() {
    return TextField(
      onChanged: (String value) {
        bill.where = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.teal[200],
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: whereFocus,
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(whenFocus);
      },
    );
  }

  TextField inputWhen() {
    return TextField(
      onChanged: (String value) {
        bill.when = value;
      },
      keyboardType: TextInputType.datetime,
      cursorColor: Colors.teal[200],
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: whenFocus,
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(priceFocus);
      },
      maxLength: 10,
    );
  }

  TextField inputPrice() {
    return TextField(
      onChanged: (String value) {
        bill.price = double.parse(value);
      },
      keyboardType: TextInputType.numberWithOptions(),
      cursorColor: Colors.teal[200],
      style: widgets.inputTextStyle(),
      decoration: widgets.inputDecoration(),
      focusNode: priceFocus,
      onSubmitted: (String value) {
        saveBill();
      },
    );
  }
}
