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
    final _emailController = TextEditingController(text: 'admin@admin.com');
    final _passwordController = TextEditingController(text: 'password');
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/illustrations/relaunch_day.svg',
                  height: 250.0,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email address'),
                    autocorrect: false,
                    validator: (value) => value.isEmpty
                        ? 'Must contain an email address.'
                        : null),
                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', hintText: 'Enter your passwrd'),
                    autocorrect: false,
                    validator: (value) =>
                        value.isEmpty ? 'Must enter your password.' : null),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: RaisedButton(
                      child: Text('LOGIN'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Response response = await authProvider.login({
                            "email": _emailController.text,
                            "password": _passwordController.text
                          });

                          if (response.statusCode == 200) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('You have logged in!'),
                            ));
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        )));
  }
}
