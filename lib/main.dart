// Packages
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import './app/router.dart';

// Providers
import './providers/auth_provider.dart';
import './providers/user_provider.dart';
import './providers/theme_provider.dart';

// Screens
import './screens/home_screen.dart';
import './screens/splash_screen.dart';
import './screens/unknown_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(BaseApp());
}

class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();

    return MultiProvider(
      providers: providers,
      child: Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, auth, themeProvider, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LaraDart',
          themeMode: themeProvider.theme,
          theme: themeProvider.isDark
              ? themeProvider.darkTheme
              : themeProvider.lightTheme,
          home: home(auth),
          onGenerateRoute: router.onGenerateRoute,
          onUnknownRoute: (settings) =>
              MaterialPageRoute(builder: (_) => UnknownScreen()),
        ),
      ),
    );
  }

  /// Evaluate if the user is authenticated
  /// then show the user the HomeScreen otherwise
  /// display the LoginScreen to force them to login
  Widget home(AuthProvider auth) {
    return auth.loggedIn
        ? HomeScreen()
        : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    // : HomeScreen(),
                    : LoginScreen(),
          );
  }

  /// Here we define our list of providers
  /// for our state management in the app
  List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider<ThemeProvider>.value(value: ThemeProvider()),
      ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
      ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
        create: (_) => UserProvider(),
        update: (context, auth, previous) =>
            UserProvider(token: auth.token, users: previous.users),
      )
    ];
  }
}
