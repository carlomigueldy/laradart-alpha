import 'package:flutter_svg/flutter_svg.dart';

import '../providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                'assets/illustrations/relaunch_day.svg',
                height: 275.0,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: LoginButton(authProvider: authProvider)),
            ],
          ),
        )));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
          color: Colors.indigo[400],
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          onPressed: () async {
            await onTapLaunch(context);
          },
          child: Text(
            'Launch',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  Future onTapLaunch(BuildContext context) async {
    Response response = await authProvider
        .login({"email": "admin@admin.com", "password": "password"});

    switch (response.statusCode) {
      case 403:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Oops'),
            contentPadding: EdgeInsets.all(30),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              )
            ],
          ),
        );
        break;
      case 200:
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo,
          content: Text(
            'You have logged in!',
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () => print('Closed'),
          ),
        ));
        break;
      default:
        Scaffold.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo,
          content: Text(
            response.data['message'],
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () => print('Closed'),
          ),
        ));
    }
  }
}
