import 'package:flutter_svg/flutter_svg.dart';

import '../providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final _emailController = TextEditingController(text: 'admin@admin.com');
    final _passwordController = TextEditingController(text: 'password');
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
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
                Center(
                  child: Column(
                    children: [
                      Text('Sign In'),
                      Text(
                        'Space App Starter',
                        style: TextStyle(fontSize: 26),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(
                  'assets/illustrations/relaunch_day.svg',
                  height: 250.0,
                ),
                Center(child: Text(_loading ? 'Logging you in...' : '')),
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
                          setState(() {
                            _loading = true;
                          });

                          Response response = await authProvider.login({
                            "email": _emailController.text,
                            "password": _passwordController.text
                          });

                          setState(() {
                            _loading = false;
                          });

                          print(response);
                        }
                      }),
                )
              ],
            ),
          ),
        )));
  }
}
