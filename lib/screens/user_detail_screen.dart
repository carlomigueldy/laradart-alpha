import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  final arguments;

  UserDetailScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      body: SafeArea(
        child: Center(
          child: Text('User Detail Screen'),
        ),
      ),
    );
  }
}
