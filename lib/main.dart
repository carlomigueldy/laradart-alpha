// Packages
import 'package:flutter/material.dart';
import 'package:laradart/providers/theme_provider.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

// Providers
import './providers/auth_provider.dart';
import './providers/user_provider.dart';

// Screens
import './screens/place_screen.dart';
import './screens/home_screen.dart';
import './screens/user_detail_screen.dart';
import './screens/users_screen.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/unknown_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onGenerateRoute: routes,
          onUnknownRoute: (settings) =>
              MaterialPageRoute(builder: (_) => UnknownScreen()),
        ),
      ),
    );
  }

  /// All of the routes should be defined in here
  Route routes(settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case UserListScreen.routeName:
        return MaterialPageRoute(builder: (_) => UserListScreen());
      case PlaceScreen.routeName:
        return MaterialPageRoute(builder: (_) => PlaceScreen(arguments));
      case UserDetailScreen.routeName:
        return MaterialPageRoute(builder: (_) => UserDetailScreen(arguments));
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
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
                    : HomeScreen(),
            // : LoginScreen(),
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

  /// All the routes are defined in here
  /// in a switch statement since this will
  /// be able to handle dynamic page requests.
}
