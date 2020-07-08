import 'package:daycare_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    // A listener is not needed so we set
    // the listen property to false
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('User Screen'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Card(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Text('Users Screen'),
                  Text(userProvider.token)
                ],
              )),
            ),
          ),
        ));
  }
}
