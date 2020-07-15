import 'package:flutter/material.dart';
import 'package:laradart/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  final arguments;

  UserDetailScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    print(arguments);
    return Scaffold(
      appBar: AppBar(title: Text(arguments)),
      body: SafeArea(
        child: Center(
          child: Text(
            'Hello there, $arguments! But you are ${authProvider.fullName}',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
