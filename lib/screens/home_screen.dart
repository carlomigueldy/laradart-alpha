import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:daycare_flutter/screens/users_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

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
              LogoutButton(authProvider: authProvider),
              SizedBox(
                height: 10.0,
              ),
              UserButton(authProvider: authProvider)
            ],
          ),
        )));
  }
}

class UserButton extends StatelessWidget {
  const UserButton({
    Key key,
    @required this.authProvider,
  }) : super(key: key);

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: () => Navigator.of(context).pushNamed(UsersScreen.routeName),
        child: Text('To Users'),
      ),
    );
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
            default:
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(response.data['message']),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () => print('Closed'),
                ),
              ));
          }
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
          },
          child: Text('Click Me')),
    );
  }
}
