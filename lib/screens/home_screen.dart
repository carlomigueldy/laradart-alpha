import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:daycare_flutter/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
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
              LoginButton(authService: authService),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () => print('ayaw lagi'),
                  child: Text(
                      authProvider.loggedIn ? 'Naka login man ka' : 'Ayaw'),
                ),
              )
            ],
          ),
        )));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.authService,
  }) : super(key: key);

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
          onPressed: () async {
            await authService
                .login({"email": "admin@admin.com", "password": "password"});

            Response response = await authService.getUser();
            print(response.statusCode);
          },
          child: Text('Click Me')),
    );
  }
}
