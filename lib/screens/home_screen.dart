import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LoginButton(authProvider: authProvider),
              SizedBox(
                height: 10.0,
              ),
              PrintButton(authProvider: authProvider),
              SizedBox(
                height: 10.0,
              ),
              LogoutButton(authProvider: authProvider)
            ],
          ),
        )));
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key key,
    @required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: () async {
          Response response = await authProvider.logout();
          print(response);
        },
        child: Text('Logout'),
      ),
    );
  }
}

class PrintButton extends StatelessWidget {
  const PrintButton({
    Key key,
    @required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: () => print('ayaw lagi'),
        child: Text(authProvider.loggedIn ? 'Naka login man ka' : 'Ayaw'),
      ),
    );
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
          onPressed: () async {
            await authProvider
                .login({"email": "admin@admin.com", "password": "password"});
          },
          child: Text('Click Me')),
    );
  }
}
