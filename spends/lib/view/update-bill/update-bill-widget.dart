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
    return DropdownButton<String>(
      value: bill.type,
      onChanged: (String newValue) {
        bill.type = newValue;
      },
      hint: Container(
        child: basicText(hintText, 28, Colors.black26),
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
