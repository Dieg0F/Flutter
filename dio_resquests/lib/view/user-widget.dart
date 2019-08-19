import 'package:dio_resquests/model/user/user-bloc.dart';
import 'package:dio_resquests/model/user/user-response.dart';
import 'package:dio_resquests/model/user/user.dart';
import 'package:dio_resquests/view/user-components.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatefulWidget {
  UserWidget() {
    bloc.getUser();
  }

  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<UserResponse>(
        stream: bloc.subject.stream,
        builder: _asyncWidgetBuilder,
      ),
    );
  }

  Widget _asyncWidgetBuilder(context, AsyncSnapshot<UserResponse> snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data.error != null && snapshot.data.error.length > 0) {
        return _buildErrorWidget(snapshot.data.error);
      } else if (snapshot.data != null) {
        return _buildUserWidget(snapshot.data);
      }
    } else if (snapshot.hasError) {
      return _buildErrorWidget(snapshot.error);
    } else {
      return _buildLoadingWidget();
    }
  }

  Widget _buildUserWidget(UserResponse data) {
    User user = data.results[0];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          userAvatar(user),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          text(user.name.first, 35, Colors.white60),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          text(user.name.last, 30, Colors.white60),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String err) {
    return error(err);
  }

  Widget _buildLoadingWidget() {
    return loading("Requesting User...");
  }
}
