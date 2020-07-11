import '../screens/user_detail_screen.dart';
import 'package:faker/faker.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    // A listener is not needed so we set
    // the listen property to false
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    final faker = Faker();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'User List',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              'https://api.adorable.io/avatars/285/${faker.person.firstName()}')),
                      title: Text(faker.person.name()),
                      subtitle: Text(faker.lorem.sentence()),
                      isThreeLine: true,
                      onTap: () => Navigator.pushNamed(
                          context, UserDetailScreen.routeName,
                          arguments: faker.person.name()),
                      onLongPress: () =>
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Hello'),
                            action: SnackBarAction(
                              onPressed: () => print('Bye'),
                              label: 'CLOSE',
                            ),
                          ))),
                  itemCount: 10,
                ))));
  }
}
