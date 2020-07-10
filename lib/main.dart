// Providers
import 'package:google_fonts/google_fonts.dart';

import './providers/auth_provider.dart';
import './providers/user_provider.dart';

// Screens
import './screens/home_screen.dart';
import './screens/users_screen.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';

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
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            themeMode: ThemeMode.dark,
            theme: ThemeData(),
            darkTheme: darkTheme(),
            home: auth.loggedIn
                ? HomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : LoginScreen(),
                  ),
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case HomeScreen.routeName:
                  return MaterialPageRoute(builder: (_) => HomeScreen());
                case UsersScreen.routeName:
                  return MaterialPageRoute(builder: (_) => UsersScreen());
                case SplashScreen.routeName:
                  return MaterialPageRoute(builder: (_) => SplashScreen());
                default:
                  return MaterialPageRoute(builder: (_) => LoginScreen());
              }
            }),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      backgroundColor: Colors.grey[900],
      primaryColor: Colors.indigo[400],
      accentColor: Colors.indigo[100],
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: Colors.grey[850], elevation: 0),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo[400],
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0))),
    );
  }
}
