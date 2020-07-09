import './providers/auth_provider.dart';
import './providers/user_provider.dart';
import './screens/home_screen.dart';
import './screens/users_screen.dart';
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
          create: (_) => UserProvider(),
          update: (context, auth, previous) =>
              UserProvider(token: auth.token, users: previous.users),
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
