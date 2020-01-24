import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spends/routes/routes.dart';

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
              child: Row(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText(
                          "Olá,",
                          18,
                          Colors.black26,
                        ),
                        widgets.spaceHorizontal(4),
                        widgets.basicText(
                          "Diego Fraga",
                          26,
                          Colors.teal[400].withOpacity(0.7),
                        ),
                      ],
                    ),
                    width: (MediaQuery.of(context).size.width * 0.5) - 24,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText(
                          "Hoje é",
                          16,
                          Colors.black26,
                        ),
                        widgets.basicText(
                          "24/01/2020",
                          18,
                          Colors.black45,
                        ),
                      ],
                    ),
                    width: (MediaQuery.of(context).size.width * 0.5) - 24,
                  )
                ],
              ),
              padding: EdgeInsets.only(
                left: 24,
                top: 28,
                right: 24,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.12,
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
                  widgets.basicText(
                      "Total gasto até agora", 23, Colors.black38),
                  widgets.spaceHorizontal(20),
                  widgets.basicText("- R\$ 5.280,00", 45, Colors.red[400]),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.40,
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
                  widgets.basicText(
                      "Lucro total até agora", 20, Colors.black38),
                  widgets.spaceHorizontal(20),
                  widgets.basicText("+ R\$ 2.720,00", 40, Colors.green[400]),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
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
                        widgets.basicText("Saldo positivo", 18, Colors.black38),
                        widgets.spaceHorizontal(5),
                        widgets.basicText(
                            "R\$ 17.720,00", 22, Colors.green[400]),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText("Gastos fixos", 18, Colors.black38),
                        widgets.spaceHorizontal(5),
                        widgets.basicText(
                            "R\$ 13.000,00", 22, Colors.purple[400]),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border(
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
            ),
            Container(
              child: Row(
                children: <Widget>[
                  InkResponse(
                    onTap: () {
                      Routes(context: context).toBills();
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          widgets.basicText(
                              "Minhas contas", 18, Colors.white60),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.teal[400],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widgets.basicText("Histórico", 18, Colors.white60),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.teal[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal,
    );
  }
}
