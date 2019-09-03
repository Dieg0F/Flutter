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

  Container inputField(Text textLabel, TextField inputText) {
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
      autofocus: true,
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
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(priceFocus);
      },
    );
  }

  TextField inputPrice() {
    return TextField(
      onChanged: (String value) {
        bill.price = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        //Save
      },
    );
  }
}
