import 'package:flutter/material.dart';
import 'package:spends/view/widgets/widgets.dart';

import '../../model/bill.dart';

class UpdateBillWidget {
  BuildContext context;
  Bill bill = new Bill();

  void setContext(BuildContext ctx) {
    this.context = ctx;
  }

  FocusNode nameFocus = new FocusNode();
  FocusNode whereFocus = new FocusNode();
  FocusNode whenFocus = new FocusNode();
  FocusNode priceFocus = new FocusNode();

  TextEditingController txNameController = new TextEditingController();
  TextEditingController txWhereController = new TextEditingController();
  TextEditingController txWhenController = new TextEditingController();
  TextEditingController txPriceController = new TextEditingController();

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          inputField(
            basicText("Gastei com o que?", 28, Colors.black54),
            inputName(),
          ),
          inputField(
            basicText("Onde fiz essa compra?", 28, Colors.black54),
            inputWhere(),
          ),
          inputField(
            basicText("Quando foi isso?", 28, Colors.black54),
            inputWhen(),
          ),
          inputField(
            basicText("E o preco?", 28, Colors.black54),
            inputPrice(),
          ),
        ],
      ),
    );
  }

  Container inputField(Text textLabel, TextFormField inputText) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textLabel,
          Flexible(
            child: inputText,
          ),
        ],
      ),
      height: 150,
    );
  }

  TextFormField inputName() {
    txNameController.text = bill.name;
    return TextFormField(
      controller: txNameController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onFieldSubmitted: (String value) {
        bill.name = value;
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(whereFocus);
      },
      autofocus: true,
    );
  }

  TextFormField inputWhere() {
    txWhereController.text = bill.where;
    return TextFormField(
      controller: txWhereController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
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
    txPriceController.text = bill.when;
    return TextFormField(
      controller: txWhenController,
      keyboardType: TextInputType.datetime,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
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
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      focusNode: priceFocus,
      onFieldSubmitted: (String value) {
        bill.name = value;
      },
      onEditingComplete: () {
        //Save
      },
    );
  }
}
