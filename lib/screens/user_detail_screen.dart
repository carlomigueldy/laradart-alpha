import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  final arguments;

  UserDetailScreen(this.arguments);

  @override
  Widget build(BuildContext context) {
    print(arguments);
    return Scaffold(
      appBar: AppBar(title: Text(arguments)),
      body: SafeArea(
        child: Center(
          child: Text(
            'Hello there, $arguments!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
