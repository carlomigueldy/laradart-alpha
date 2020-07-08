import 'package:daycare_flutter/models/user.dart';
import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:daycare_flutter/providers/user_provider.dart';
import 'package:daycare_flutter/screens/home_screen.dart';
import 'package:daycare_flutter/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(),
          update: (context, value, previous) => UserProvider(
              token: value.token, users: previous == null ? [] : previous),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            UsersScreen.routeName: (context) => UsersScreen()
          }),
    );
  }
}
