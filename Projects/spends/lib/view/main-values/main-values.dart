import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:spends/view/widgets/widgets.dart' as widgets;

class MainValues extends StatefulWidget {
  MainValues({Key key}) : super(key: key);

  @override
  _MainValuesState createState() => _MainValuesState();
}

class _MainValuesState extends State<MainValues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: widgets.basicText("R\$ 25,00", 45, Colors.green[400]),
              ),
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.10),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                color: Colors.white,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText(
                            "R\$ 37.500,00", 22, Colors.green[400]),
                        widgets.basicText(
                            "R\$ 37.500,00", 22, Colors.green[400]),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.10),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText("R\$ 25.500,00", 22, Colors.red[400]),
                        widgets.basicText("R\$ 25.500,00", 22, Colors.red[400]),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.25),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        left: BorderSide(
                          color: Colors.grey.withOpacity(0.25),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.teal,
    );
  }
}
