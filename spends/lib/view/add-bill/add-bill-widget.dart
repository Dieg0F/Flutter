import 'package:flutter/material.dart';
import 'package:spends/view/widgets/widgets.dart';

import '../../model/bill.dart';

class AddBillWidget {
  BuildContext context;
  Bill bill = new Bill();

  void setContext(BuildContext ctx) {
    this.context = ctx;
  }

  FocusNode nameFocus = new FocusNode();
  FocusNode whereFocus = new FocusNode();
  FocusNode whenFocus = new FocusNode();
  FocusNode priceFocus = new FocusNode();

  String dropdownValue = "Selecione um tipo";

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          inputDropdownField(
            basicText("Que tipo de compra foi essa?", 28, Colors.black54),
            dropdownType(),
          ),
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
    return DropdownButton<String>(
      value: bill.type,
      onChanged: (String newValue) {
        bill.type = newValue;
        dropdownValue = newValue;
      },
      hint: Container(
        child: basicText(dropdownValue, 26, Colors.black26),
      ),
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black45,
        size: 30,
      ),
      underline: Container(),
      items: <String>['Transporte', 'Carro', 'Comida', 'Telefone']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            child: basicText(value, 26, Colors.black54),
          ),
        );
      }).toList(),
    );
  }

  TextField inputName() {
    return TextField(
      onChanged: (String value) {
        bill.name = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
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
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
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
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      focusNode: whenFocus,
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(priceFocus);
      },
    );
  }

  TextField inputPrice() {
    return TextField(
      onChanged: (String value) {
        bill.price = double.parse(value);
      },
      keyboardType: TextInputType.numberWithOptions(),
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      focusNode: priceFocus,
      onSubmitted: (String value) {
        //Save
      },
    );
  }
}
