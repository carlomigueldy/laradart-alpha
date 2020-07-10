import 'package:daycare_flutter/screens/splash_screen.dart';

import '../providers/auth_provider.dart';
import '../screens/users_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (item) => print(item),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account), title: Text('Users')),
            BottomNavigationBarItem(
                icon: Icon(Icons.all_inclusive), title: Text('Cool'))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              LogoutButton(authProvider: authProvider),
              SizedBox(
                height: 10.0,
              ),
              UserButton(authProvider: authProvider),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SplashScreen.routeName),
                  child: Text('To Splash'),
                ),
              )
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
        onPressed: () =>
            Navigator.of(context).pushNamed(UserListScreen.routeName),
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
