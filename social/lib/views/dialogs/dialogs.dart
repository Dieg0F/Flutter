import 'package:flutter/material.dart';

class Dialogs {
  bool isLoading = false;

  BuildContext ctx;

  Dialogs({this.ctx});

  showLoading(String message) {
    print("Showing Loading");
    isLoading = true;
    return showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (buildrCtx) {
        return AlertDialog(
          content: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Container(
                  child: CircularProgressIndicator(),
                  width: 20,
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                ),
                Flexible(
                  child: Container(
                    child: Text(
                      message,
                      maxLines: 2,
                      softWrap: true,
                    ),
                    width: 200,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white30,
                style: BorderStyle.solid,
                width: 1,
              ),
              borderRadius: new BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            height: 80,
          ),
          backgroundColor: Colors.transparent,
        );
      },
    );
  }

  hideLoading() {
    if (isLoading) {
      print("Hiding Loading");
      Navigator.pop(ctx);
    }
    isLoading = false;
  }
}
